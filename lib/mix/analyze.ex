defmodule Mix.Tasks.Analyze do
  use Mix.Task

  @regex_delimiter ~r/[\d*,?.?:?;?\s+\d*]/i

  def run(_) do
    TextAnalyzer.Client.main(IO)
  end

  def read_words(path) do
    FileAdapter.read(path)
    |> parse_words
  end

  def parse_words(words) do
    String.split(words, @regex_delimiter, trim: true)
  end

end
