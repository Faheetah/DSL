defmodule DSLTest do
  use ExUnit.Case
  use DSL

  test "run a module" do
    node "master", "workspace/foo" do
      trigger do
        Git.ref "refs/heads/master"
      end

      tasks do
        Shell.echo "hello shell"
        Shell.run ["whoami"]
        Shell.run ["ls", "-1"]
        Git.clone(repo: "bar.git", branch: "master")
        Git.pull
      end
    end
  end
end
