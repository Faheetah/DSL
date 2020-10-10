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

  defmacro node(name, workspace, do: block) do
    IO.puts "Running in #{name}:#{workspace}"
    quote do
      {unquote(name), unquote(block)}
    end
  end

  defmacro do_task(definition, do: _content) do
    IO.inspect definition
    quote do: {}
  end

  defmacro tasks(do: block) do
    {:ok, log_pid} = TaskLogger.start_link([verbose: false])
    # DSL parser hook here to allow things like assignments
    case block do
      {:__block__, _, commands} -> commands
      # single commands come unpacked without __block__
      command -> [command]
    end
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
