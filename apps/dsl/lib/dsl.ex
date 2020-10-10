defmodule DSL do
  defmacro __using__(_opts) do
    quote do
      import DSL
      import Shell
      import Git
    end
  end

  def trigger(block), do: block

  def log(module, method, message), do: IO.puts "#{module}.#{method}: #{message}"

  def run(code) do
    job(Code.string_to_quoted(code))
  end

  def job({:ok, code}) do
    {:ok, log_pid} = TaskLogger.start_link([verbose: false])
    normalize_block(code)
    |> Stream.map(fn command ->
      {:node, _, [name, workspace | _]} = command
      TaskLogger.log(log_pid, {:start, "node.#{name}:#{workspace}"})
      # todo this needs to take a stream or something polymorphic out
      run = quote do
        use DSL
        unquote command
      end
      {result, _} = Code.eval_quoted run
      {name, workspace, result}
    end)
    |> Enum.each(fn {name, workspace, _} ->
      TaskLogger.log(log_pid, {:end, "node.#{name}:#{workspace}"})
    end)
  end

  def normalize_block(code) do
    case code do
      {:__block__, _, commands} -> commands
      # single commands come unpacked without __block__
      command -> [command]
    end
  end

  defmacro node(_name, workspace, do: block) do
    File.mkdir_p(workspace)
    run = quote do
      use DSL
      unquote block
    end
    # Code.eval_quoted(run)
    File.cd!(workspace, fn -> Code.eval_quoted(run) end)
  end

  defmacro tasks(do: block) do
    {:ok, log_pid} = TaskLogger.start_link([verbose: false])
    # DSL parser hook here to allow things like assignments
    normalize_block(block)
    |> Stream.map(fn command ->
      {{:., _, [{:__aliases__, _, [module]}, method]}, _, _} = command
      TaskLogger.log(log_pid, {:start, "#{module}.#{method}"})
      # todo this needs to take a stream or something polymorphic out
      {result, _} = Code.eval_quoted(command)
      TaskLogger.log(log_pid, {:message, "#{module}.#{method} >> #{result}"})
      {module, method, result}
    end)
    |> Enum.each(fn {module, method, _} ->
      TaskLogger.log(log_pid, {:end, "#{module}.#{method}"})
    end)

    TaskLogger.get_logs(log_pid)
  end
end
