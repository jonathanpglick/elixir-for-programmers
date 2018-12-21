defmodule BotTextClient do
  defdelegate start(), to: BotTextClient.Interact
end
