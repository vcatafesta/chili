defmodule LineCounter do
  def count_lines(file_path) do
    with {:ok, file} <- File.open(file_path),
         {:ok, lines} <- Enum.reduce(IO.stream(file, :line), 0, fn line, count -> count + 1 end) do
      lines
    else
      {:error, reason} -> IO.puts("Error: #{reason}")
    after
      :file.close(file)
    end
  end
end

IO.puts(LineCounter.count_lines("file.txt"))
