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


end
