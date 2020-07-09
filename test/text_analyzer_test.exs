defmodule TextAnalyzerTest do
  use ExUnit.Case
  doctest TextAnalyzer

  test "greets the world" do
    assert TextAnalyzer.hello() == :world
  end
end
