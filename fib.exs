defmodule Fib do
  def fib(n) do
    cache_pid = FibCache.start(%{0 => 0, 1 => 1})
    fib(cache_pid, n)
  end

  def fib(cache_pid, n) do
    case FibCache.get(cache_pid, n) do
      {:miss} ->
        value = fib(cache_pid, n - 1) + fib(cache_pid, n - 2)
        FibCache.put(cache_pid, n, value)
        value

      {:hit, value} ->
        value
    end
  end
end
