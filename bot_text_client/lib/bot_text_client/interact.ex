defmodule BotTextClient.Interact do
  alias TextClient.{State}
  alias BotTextClient.Bot

  def start() do
    Hangman.new_game()
    |> setup_state()
    |> Bot.play()
  end

  defp setup_state(game) do
    %State{
      game_service: game,
      tally: Hangman.tally(game)
    }
  end
end
