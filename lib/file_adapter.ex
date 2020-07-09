defmodule Analyzer.FileAdapter do

  def read(path) do
    {:ok, pid} = File.open(path, [:read])
    IO.read(pid, :all)
  end

end
