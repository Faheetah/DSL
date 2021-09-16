defmodule DSLTest do
  use ExUnit.Case

  test "run a module" do
    code = quote do
      host "self", dir: "workspace/bar" do
        tasks do
          # Shell.cmd ["pwd"]
          # Shell.raw "echo bar > bar"
          # Shell.raw "cat bar"
          Foo.bar "baz" do
            "do"
          else
            "else"
          catch
            "catch"
          rescue
            "rescue"
          after
            "after"
          end
        end
      end
    end
    DSL.run(code)
  end
end
