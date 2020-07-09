defmodule TextAnalyzer.Text do

  alias Analyzer.FileAdapter

  def run do
    IO.inspect("ran")
  end

  def read_words(path) do
    FileAdapter.read(path)
    |> parse_words
  end
end
