defmodule Journal do
  @moduledoc """
  Documentation for `Journal`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Journal.hello()
      :world

  """
  def main([]) do
    # default
    # make sure entries directory exists
    if ensure_entries_directory_exists("entries") == true do
        File.write("entries, #{datestamp()}.md", datestamp())
    else
        File.mkdir("journal/entries")
        File.write("entries, #{datestamp()}.md", datestamp())
    end

    # make a date-stamped file

  end

  def main(args) do
    options = [switches: [folder: :string, file: :string]]
    {opts, _, _} = OptionParser.parse(args, options)
    IO.inspect(opts)
  end

  def ensure_entries_directory_exists(path) do
    File.exists?(path)
  end
  def datestamp() do
    date = Date.utc_today()
    "#{date.year}-#{date.month}-#{date.day}"
  end

  def hello do
    :world
  end
end
