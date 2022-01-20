defmodule Foo do

  defmacro bar(message, [do: do_block, else: else_block, after: after_block]) do
    quote do
      result = if not unquote(do_block) do
        unquote(else_block)
      end
      unquote(after_block)
    end
  end
end
