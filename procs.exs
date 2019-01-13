defmodule Procs do
  def greeter(count) do
    receive do
      {:boom, reason} ->
        exit(reason)

      {:add, number} ->
        greeter(count + number)

      {:reset} ->
        greeter(0)

      _ ->
        IO.puts("#{count}: Hello")
        greeter(count)
    end
  end
end
