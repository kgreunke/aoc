defmodule Aoc.Day1 do
  def process_file(path) do
    File.stream!(path)
    |> Enum.reduce({50, 0, 0}, &rotate/2)
  end

  def rotate(<<"L", moves::binary>>, {start, zeros, click_zeros}) do
    {moves, initial_clicks} =
      moves |> String.trim() |> String.to_integer() |> clicks()

    case normalize(start, -moves) do
      {x, clicks} when x === 0 ->
        {x, zeros + 1, click_zeros + 1 + clicks + initial_clicks}

      {x, clicks} ->
        {x, zeros, click_zeros + clicks + initial_clicks}
    end
  end

  def rotate(<<"R", moves::binary>>, {start, zeros, click_zeros}) do
    {moves, initial_clicks} =
      moves |> String.trim() |> String.to_integer() |> clicks()

    case normalize(start, moves) do
      {x, clicks} when x === 0 ->
        {x, zeros + 1, click_zeros + clicks + initial_clicks}

      {x, clicks} ->
        {x, zeros, click_zeros + clicks + initial_clicks}
    end
  end

  defp normalize(start, moves) do
    clicks =
      case start do
        0 -> 0
        _ -> 1
      end

    case start + moves do
      number when number > 99 -> {Integer.mod(number, 100), clicks}
      number when number < 0 -> {number + 100, clicks}
      number -> {number, 0}
    end
  end

  defp clicks(number) do
    {
      Integer.mod(number, 100),
      div(number, 100)
    }
  end
end
