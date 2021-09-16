defmodule DSL.File do
  defmacro dir(name, do: block) do
    IO.puts "Running in dir #{name}"
    quote do
      use DSL
      File.cd!(unquote(name), fn -> Code.eval_quoted(unquote(block)) end)
    end
  end
end
