defmodule Shell do
  def echo(string) do
    "echo #{string}"
  end

  def cmd(args) do
    [command | args] = args
    {out, _} = System.cmd(command, args)
    String.trim(out)
  end

  def raw(command) do
    :os.cmd(String.to_charlist(command))
    |> case do
      [] -> true
      out -> String.trim("#{out}")
    end
  end
end
