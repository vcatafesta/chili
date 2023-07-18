defmodule FileReader do
  def read_file(file_path) do
    with {:ok, file} <- File.open(file_path),
         {:ok, lines} <- IO.read(file, :all) do
      lines |> String.split("\n") |> Enum.each(&IO.puts/1)
    else
      {:error, reason} -> IO.puts("Error: #{reason}")
    after
      :file.close(file)
    end
  end
end

FileReader.read_file("file.txt")
