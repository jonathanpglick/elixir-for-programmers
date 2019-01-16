defmodule SocketGallowsWeb.HangmanChannel do
  use Phoenix.Channel
  require Logger

  def join("hangman:game", _, socket) do
    game = Hangman.new_game()
    socket = assign(socket, :game, game)
    {:ok, socket}
  end

  def handle_in("new_game", _, socket) do
    socket
    |> assign(:game, Hangman.new_game())
    |> push_tally()
  end

  def handle_in("make_move", guess, socket) do
    socket.assigns.game
    |> Hangman.make_move(guess)

    push_tally(socket)
  end

  def handle_in("tally", _, socket) do
    push_tally(socket)
  end

  def handle_in(topic, _, socket) do
    Logger.error("Unhandled message: " <> topic)
    {:noreply, socket}
  end

  defp push_tally(socket) do
    tally = socket.assigns.game |> Hangman.tally()
    push(socket, "tally", tally)
    {:noreply, socket}
  end
end
