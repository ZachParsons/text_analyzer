defmodule TextAnalyzer.Text do
  alias TextAnalyzer.FileAdapter
  alias TextAnalyzer.Word

  # @read_path "./data/exercisedocument.txt"
  @stopwords_path "./data/stopwords.txt"
  @regex_delimiter ~r/[\d*,?.?:?;?\s+\d*]/i
  @amount 25

  def run(path) do
    stopwords = read_words(@stopwords_path)
    filename = get_filename(path)

    path
    |> read_words()
    |> parse_roots()
    |> filter_out(stopwords)
    |> count_words()
    |> limit_words(@amount)
    |> format_file_content()
    |> write_file(filename)
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
    |> Enum.map(fn word ->
      Word.stem_word(word)
    end)
  end

  def filter_out(list, stopwords) do
    list
    |> Enum.filter(fn word ->
      !Enum.any?(stopwords, fn stopword -> stopword === word end)
    end)
  end

  def count_words(list) do
    list
    |> Enum.reduce(%{}, fn cur, acc ->
      Map.update(acc, cur, 1, &(&1 + 1))
    end)
    |> Enum.sort(fn {_k1, v1}, {_k2, v2} -> v1 > v2 end)
  end

  def limit_words(list, amount), do: Enum.take(list, amount)

  def format_file_content(content) do
    Enum.map(content, fn tuple ->
      elem(tuple, 0) <>
        ": " <>
        Integer.to_string(elem(tuple, 1)) <>
        "\n"
    end)
  end

  def write_file(content, filename) do
    FileAdapter.write(content, filename)
    content
  end

  def get_filename(read_path) do
    results =
      ~r/(?<filename>\w+).(?<extension>\w{2,4})$/i
      |> Regex.named_captures(read_path)

    results["filename"]
  end
end
