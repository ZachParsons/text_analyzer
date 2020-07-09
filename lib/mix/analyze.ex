defmodule Mix.Tasks.Analyze do
  use Mix.Task

  def run(_) do
    TextAnalyzer.Client.main(IO)
  end
end
