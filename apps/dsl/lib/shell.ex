defmodule Shell do
  def echo(string) do
    "echo #{string}"
  end

  def run(args) do
    [command | args] = args
    {out, _} = System.cmd(command, args)
    String.trim(out)
  end
end
