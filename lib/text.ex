defmodule TextAnalyzer.Text do

  alias TextAnalyzer.FileAdapter
  alias TextAnalyzer.Word


  @read_path "./data/exercisedocument.txt"
  @stopwords_path "./data/stopwords.txt"
  @regex_delimiter ~r/[\d*,?.?:?;?\s+\d*]/i
  @amount 25


  def run do
    IO.inspect("ran")

    stopwords = read_words(@stopwords_path)

    @read_path
    |> read_words()
    |> parse_roots()
    |> filter_out(stopwords)
    |> count_words()
    |> limit_words(@amount)

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

  def filter_out(list, stopwords) do
    list
    |> Enum.filter(fn(word)->
      !Enum.any?(stopwords, fn(stopword)-> stopword === word end)
    end)
  end

  def count_words(list) do
    list
    |> Enum.reduce(%{}, fn(cur, acc)->
      Map.update(acc, cur, 1, &(&1 + 1))
    end)
    |> Enum.sort(fn({_k1, v1}, {_k2, v2})-> v1 > v2 end)
  end

  def limit_words(list, amount), do: Enum.take(list, amount)

end
