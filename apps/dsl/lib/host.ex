defmodule DSL.Host do
  defmacro host(name, [dir: dir], do: block) do
    dir =
      case dir do
        nil -> "."
        x -> x
      end

    IO.puts "Running on #{name} in dir: #{dir}"

    File.mkdir_p(dir)
    run = quote do
      use DSL
      unquote block
    end
    # Code.eval_quoted(run)
    File.cd!(dir, fn -> Code.eval_quoted(run) end)
  end
  # defmacro host(name, do: block), do: host(name, [dir: "."], block)
  defmacro host(name, [do: _block]), do: IO.puts(name)
end
