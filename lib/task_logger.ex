defmodule TaskLogger do
  use GenServer

  def log(pid, message) do
     GenServer.call(pid, {:log, message})
  end

  def get_logs(pid) do
    GenServer.call(pid, {:get_log})
  end

  def start_link([verbose: verbose]) do
    GenServer.start_link(__MODULE__, [verbose: verbose])
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:log, message}, _from, state) do
    verbose = Keyword.get(state, :verbose, false)
    cond do
      verbose == true ->
        IO.inspect message
        {:reply, state, state ++ [message]}
      true -> case message do
        {:message, message} ->
          IO.puts message
          {:reply, state, state ++ [message]}
        _ ->
          {:reply, state, state ++ [message]}
      end
    end
  end

  def handle_call({:get_log}, _from, state) do
    {:reply, state, state}
  end
end
