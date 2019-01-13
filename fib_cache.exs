defmodule FibCache do
  def start(initial_state) do
    {:ok, pid} = Agent.start_link(fn -> initial_state end)
    pid
  end

  def get(agent, key) do
    case Agent.get(agent, &Map.get(&1, key)) do
      nil -> {:miss}
      value -> {:hit, value}
    end
  end

  def put(agent, key, value) do
    Agent.update(agent, &Map.put(&1, key, value))
  end
end
