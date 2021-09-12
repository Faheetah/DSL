defmodule DSLTest do
  use ExUnit.Case

  test "run a module" do
    code = quote do
      node "master", "workspace/bar" do
        tasks do
          Shell.cmd ["pwd"]
          Shell.raw "echo barber > bar"
          Shell.raw "cat bar"
        end
      end

      node "master", "workspace/foo" do
        tasks do
          Shell.cmd ["pwd"]
          Shell.raw "echo a > a"
          Shell.raw "echo b > b"
          Shell.raw "ls -1"
          Shell.cmd ["cat", "a"]
          Shell.cmd ["ls", "-1"]
        end
      end
    end
    DSL.run(code)
  end
end
