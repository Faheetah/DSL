defmodule Git do

  def ref(ref) do
    "listening on #{ref}"
  end

  def clone(repo: repo, branch: branch) do
    "git clone #{repo} #{branch}"
  end

  def pull() do
    "git pull"
  end
end
