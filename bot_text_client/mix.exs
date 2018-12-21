defmodule BotTextClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :bot_text_client,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:hangman, path: "../hangman"},
      {:text_client, path: "../text_client"},
      {:dictionary, path: "../dictionary"}
    ]
  end
end
