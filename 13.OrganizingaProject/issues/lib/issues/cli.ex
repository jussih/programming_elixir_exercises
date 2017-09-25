defmodule Issues.CLI do

  @default_count 4
  @columns Application.get_env(:issues, :output_columns)

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a 
  table of the last _n_ issues in a github project
  """

  def run(argv) do
    argv
    |> parse_args()
    |> process()
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a github user name, project name, and (optionally)
  the number of entries to format.

  Return a tuple of `{ user, project, count }`, or `:help` if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean],
                                     aliases:  [h:    :help])
    case  parse  do
      {[help: true], _, _}           -> :help
      {_, [user, project, count], _} -> {user, project, String.to_integer(count)}
      {_, [user, project], _}        -> {user, project, @default_count}
      _                              -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [count | #{@default_count}]
    """
    System.halt(0)
  end

  def process({user, project, count}) do
    user
    |> Issues.GithubIssues.fetch(project)
    |> decode_response()
    |> sort_into_ascending_order()
    |> Enum.take(count)
    |> print_table()
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    message = Map.get(error, "message", "error")
    IO.puts("Error fetching from Github: #{message}")
    System.halt(2)
  end

  def sort_into_ascending_order(list_of_issues) do
    Enum.sort(list_of_issues,
              fn i1, i2 -> Map.get(i1, "created_at") <= Map.get(i2, "created_at") end)
  end

  def print_table(list_of_issues) do
    columns_with_size =
      @columns
      |> Enum.map(fn x -> {x, String.length(x)} end)
      |> calculate_column_sizes(list_of_issues)
    print_header(columns_with_size)
    print_issues(columns_with_size, list_of_issues)
  end

  def calculate_column_sizes(columnskv, []), do: columnskv
  def calculate_column_sizes(columnskv, [issue | tail]) do
    columns = for {column, size} <- columnskv do
      {column, max(size, get_len(Map.get(issue, column)))}
    end
    calculate_column_sizes(columns, tail)
  end

  def get_len(thing) when is_integer(thing), do: String.length(Integer.to_string(thing))
  def get_len(thing) when is_binary(thing), do: String.length(thing)

  def print_header(columns) do
    print_row(columns)
    print_row(Enum.map(columns, fn {_name, len} -> {String.pad_leading("", len, "-"), len} end), "-+-")
  end

  def print_row(row, divider \\ " | ") do
    format_columns(row, divider)
    |> IO.puts()
  end

  def format_columns([{name, len} | tail], divider) do
    # print first column
    format_column_n(tail, String.pad_trailing("#{name}", len), divider)
  end

  def format_column_n([], row, _divider), do: row
  def format_column_n([{name, len} | tail], row, divider) do
    format_column_n(tail, row <> "#{divider}" <> String.pad_trailing("#{name}", len), divider)
  end

  def print_issues(_columns, []), do: nil
  def print_issues(columns, [issue | list_of_issues]) do
    columns
    |> Enum.map(fn {name, len} -> {Map.get(issue, name), len} end)
    |> print_row()
    print_issues(columns, list_of_issues)
  end

end

