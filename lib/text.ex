defmodule TextAnalyzer.Text do

  alias TextAnalyzer.FileAdapter

  @read_path "./data/exercisedocument.txt"
  @stopwords_path "./data/stopwords.txt"
  @regex_delimiter ~r/[\d*,?.?:?;?\s+\d*]/i


  def run do
    IO.inspect("ran")

    @read_path
    |> read_words()
  end

  def read_words(path) do
    FileAdapter.read(path)
    |> parse_words
  end

  def parse_words(words) do
    String.split(words, @regex_delimiter, trim: true)
  end

  def parse_roots(list) do
    list
    |> Enum.map(fn(word)->
      Word.stem_word(word)
    end)
  end
end
