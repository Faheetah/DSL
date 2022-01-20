defmodule DSL.Worker do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def next_number do
    GenServer.call __MODULE__, :next_number
  end

  def next_number(i) do
    GenServer.call __MODULE__, {:next_number, i}
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:next_number, i}, _from, state) do
    {:reply, state, state + i}
  end

  def handle_call(:next_number, _from, state) do
    {:reply, state, state + 1}
  end
end
