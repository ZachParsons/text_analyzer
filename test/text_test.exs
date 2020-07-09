defmodule AnalyzerTextTest do
  use ExUnit.Case
  doctest TextAnalyzer.Text
  alias TextAnalyzer.Text

  @correctly_split ["ABC", "DEF", "GHI", "JKL"]

  describe "parse_words/1" do
    test "splits on spaces" do
      spaces = " ABC DEF GHI JKL "
      result = Text.parse_words(spaces)
      assert result == @correctly_split
    end

    test "excludes commas" do
      commas = "ABC DEF, GHI JKL"
      result = Text.parse_words(commas)
      assert result == @correctly_split
    end

    test "excludes periods" do
      periods = "ABC DEF. GHI JKL"
      result = Text.parse_words(periods)
      assert result == @correctly_split
    end

    test "excludes colons" do
      colons = "ABC DEF: GHI JKL"
      result = Text.parse_words(colons)
      assert result == @correctly_split
    end

    test "excludes semicolons" do
      semicolons = "ABC DEF; GHI JKL"
      result = Text.parse_words(semicolons)
      assert result == @correctly_split
    end

    test "includes hyphenated words" do
      hyphens =  "ABC DEF-GHI JKL"
      result = Text.parse_words(hyphens)
      assert result == ["ABC", "DEF-GHI", "JKL"]
    end

    test "excludes numbers" do
      numbers = "ABC 1 1000000 1,000 1,000,000,000 DEF"
      result = Text.parse_words(numbers)
      assert result == ["ABC", "DEF"]
    end
  end

  test "parse_roots/1" do
    words = ["ABCL", "DEFLZ", "GHIEVM", "JKLZQ", "MNOEZL", "PQRPZL"]
    result = Text.parse_roots(words)
    assert result == ["ABC", "DEF", "GHI", "JKL", "MNOR", "PQRAZ"]
  end

  test "filter_out/2" do
      words = ["ABC", "DEF", "GHI"]
      stopwords = ["DEF"]
      result = Text.filter_out(words, stopwords)
      assert result == ["ABC", "GHI"]
  end

  test "count_words/1" do
    words = ["ABC", "DEF", "DEF", "GHI", "GHI", "GHI"]
    result = Text.count_words(words)
    assert result == [
                        {"GHI", 3},
                        {"DEF", 2},
                        {"ABC", 1}
                      ]
  end

  test "limit_words" do
    words = [ {"GHI", 3}, {"DEF", 2}, {"ABC", 1} ]
    result = Text.limit_words(words, 2)
    assert result == [
                        {"GHI", 3},
                        {"DEF", 2}
                      ]
  end

  test "format_file_content/1" do
    content = [{"ABC", 1}, {"DEF", 2}]
    result = Text.format_file_content(content)
    assert result == ["ABC: 1\n", "DEF: 2\n"]
  end

end
