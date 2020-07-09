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
  end


end
