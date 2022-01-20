defmodule DSL.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {DSL.Worker, 0}
    ]

    opts = [strategy: :one_for_one, name: DSL.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
