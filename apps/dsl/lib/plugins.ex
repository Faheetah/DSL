defmodule Plugins do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def register(module) do
    GenServer.call __MODULE__, {:register, module}
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:register, module}, _from, state) do
    {:reply, state, [state | [module: module]]}
  end
end
