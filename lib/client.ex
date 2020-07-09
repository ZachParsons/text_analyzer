defmodule TextAnalyzer.Client do

  alias TextAnalyzer.Text

  def main(io \\ IO) do
    Text.run()
  end
end
