defmodule TextAnalyzer.Client do

  alias TextAnalyzer.Text

  def main(io \\ IO) do
    greeting()

    path =
      prompt()
      |> receive_input(io)

    analyze(path)
    |> print_report()

  end

  defp greeting, do: IO.puts "Welcome to the CLI Text Analyzer"
  defp prompt do
    "Please enter the filepath of the document you want to analyze.\n"
  end

  def receive_input(message, io) do
    io.gets(message)
    |> String.trim
  end

  def analyze(path) do
    Text.run(path)
  end

  defp print_report(report) do
    IO.puts "Here are the 25 most frequent words in the document with their word count:\n"
    IO.puts report
  end
end
