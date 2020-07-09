defmodule TextAnalyzerWordTest do
  use ExUnit.Case
  doctest TextAnalyzer.Word
  alias TextAnalyzer.Word

  test "add_suffixes/1" do
    result1 = Word.add_suffixes("ABCEZL")
    assert result1 == "ABCR"
    result2 = Word.add_suffixes("ABCPZL")
    assert result2 == "ABCAZ"
  end

  test "get_added_root/3" do
    regex1 = nil
    acc1 = "ABC"
    suffix1 = "R"
    result1 = Word.get_added_root(regex1, acc1, suffix1)
    assert result1 == acc1

    regex2 = %{"root" => "DEF"}
    acc2 = "ABC"
    suffix2 = "R"
    result2 = Word.get_added_root(regex2, acc2, suffix2)
    assert result2 == regex2["root"] <> suffix2
  end

end
