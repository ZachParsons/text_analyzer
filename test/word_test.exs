defmodule TextAnalyzerWordTest do
  use ExUnit.Case
  doctest TextAnalyzer.Word
  alias TextAnalyzer.Word

  test "stem_word/1" do
    assert Word.stem_word("ABC") == "ABC"
    assert Word.stem_word("ABCL") == "ABC"
    assert Word.stem_word("ABCLZ") == "ABC"
    assert Word.stem_word("ABCEVM") == "ABC"
    assert Word.stem_word("ABCZQ") == "ABC"
    assert Word.stem_word("ABCEZL") == "ABCR"
    assert Word.stem_word("ABCPZL") == "ABCAZ"
  end

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

  test "remove_suffixes/1" do
    result1 = Word.remove_suffixes("ABCL")
    assert result1 == "ABC"
    result2 = Word.remove_suffixes("ABCLZ")
    assert result2 == "ABC"
    result3 = Word.remove_suffixes("ABCEVM")
    assert result3 == "ABC"
    result4 = Word.remove_suffixes("ABCZQ")
    assert result4 == "ABC"
  end

  test "concat_with_or/2" do
    suffix1 = "L"
    result1 = Word.concat_with_or("", suffix1)
    assert result1  == "L"

    suffix2 = "LZ"
    result2 = Word.concat_with_or("L", suffix2)
    assert result2  == "L|LZ"
  end

  test "get_removed_root/2" do
    root1 = nil
    word1 = "ABC"
    result1 = Word.get_removed_root(root1, word1)
    assert result1 == word1

    root2 = %{"root" => "DEF"}
    word2 = "GHU"
    result2 = Word.get_removed_root(root2, word2)
    assert result2 == root2["root"]
  end

  test "handle_result/2" do
    root1 = ""
    word1 = "ABC"
    result1 = Word.handle_result(root1, word1)
    assert result1 == word1

    root2 = "DEF"
    word2 = "GHI"
    result2 = Word.handle_result(root2, word2)
    assert result2 == root2
  end

end
