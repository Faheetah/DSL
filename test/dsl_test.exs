defmodule DSLTest do
  use ExUnit.Case

  test "run a module" do
    code = quote do
      host "self", dir: "workspace/bar" do
        tasks do
          Shell.cmd ["pwd"]
          Shell.raw "echo bar > bar"
          Shell.raw "cat bar"
        end
      end
    end
    DSL.run(code)
  end
end
