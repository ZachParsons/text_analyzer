defmodule TextAnalyzer.Word do
  @moduledoc """
    """

  @suffixes ["L", "LZ", "EVM", "ZQ"]

  @root_additions %{
    "EZL" => "R",
    "PZL" => "AZ"
  }

  def stem_word(word) do
    word
    |> add_suffixes()
    |> remove_suffixes()
  end

  def add_suffixes(word) do
    @root_additions
    |> Enum.reduce(word, fn({k, v}), acc ->
      ~r/(?<root>^\w+)(?<suffix>#{k})$/i
      |> Regex.named_captures(word)
      |> get_added_root(acc, v)
    end)
  end

  def get_added_root(nil, acc, _new_suffix), do: acc
  def get_added_root(found, _acc, new_suffix), do: found["root"] <> new_suffix


  def remove_suffixes(word) do
    stemmer = create_stemmer(@suffixes)

    Regex.named_captures(stemmer, word)
    |> get_removed_root(word)
  end

  def create_stemmer(list) do
    or_suffixes =
      list
      |> Enum.reduce("", fn(cur, acc)-> concat_with_or(acc, cur) end)

    ~r/(?<root>^\w+)(?<suffix>#{or_suffixes})$/i
  end

  def concat_with_or("", cur), do: cur
  def concat_with_or(acc, cur), do: acc <> "|" <> cur

  def get_removed_root(nil, word), do: word
  def get_removed_root(found, _word), do: found["root"]

  def handle_result("", word), do: word
  def handle_result(root, _word), do: root
end
