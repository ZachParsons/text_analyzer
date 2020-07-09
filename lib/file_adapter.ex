defmodule TextAnalyzer.FileAdapter do
  @moduledoc """
  """

  @write_path "./data/analyzed/"

  def read(path) do
    {:ok, pid} = File.open(path, [:read])
    IO.read(pid, :all)
  end

  def write(content, filename) do
    # _ =
      @write_path
      |> File.exists?()
      |> ensure_directory()

      set_filepath(@write_path, filename)
      |> File.write(content)

      content
  end

  def set_filepath(path, filename), do: path <> filename <> ".txt"

  def ensure_directory(false), do: File.mkdir(@write_path)
  def ensure_directory(true), do: nil

end
