defmodule Aoc.Y2025.Day2 do
  def process_file(file) do
    File.read!(file)
    |> String.trim()
    |> String.split(",")
    |> Enum.flat_map(&rangeify_ranges/1)
    |> Enum.reduce(0, &check_id/2)
  end

  def process_file_extra(file) do
    File.read!(file)
    |> String.trim()
    |> String.split(",")
    |> Enum.flat_map(&rangeify_ranges/1)
    |> Enum.reduce(0, &check_id(&1, &2, factorize: true))
  end

  def rangeify_ranges(input) do
    input
    |> String.split("-")
    |> then(fn [head, tail] ->
      String.to_integer(head)..String.to_integer(tail)
    end)
    |> Range.to_list()
  end

  def check_id(id, factors) when is_integer(id) and is_list(factors) do
    factors
    |> Enum.any?(fn factor ->
      Regex.compile!("^(.{#{factor}})\\1+$")
      |> Regex.match?("#{id}")
    end)
    |> case do
      true -> id
      _ -> 0
    end
  end

  def check_id(id, total, opts \\ [])

  def check_id(id, total, factorize: true) do
    total + check_id(id, factorize(String.length("#{id}")))
  end

  def check_id(id, total, _opts) do
    total + check_id(id)
  end

  def check_id(id) when is_integer(id) do
    check_id(Integer.to_string(id))
  end

  def check_id(<<"0", rest::binary>> = arg) when is_binary(arg) do
    check_id(rest)
  end

  def check_id(id) when is_binary(id) and rem(byte_size(id), 2) === 0 do
    id
    |> String.split_at(div(String.length(id), 2))
    |> case do
      {head, tail} when head === tail -> String.to_integer(id)
      _ -> 0
    end
  end

  def check_id(_) do
    0
  end

  def factorize(length) do
    1..length
    |> Enum.reduce_while(%{break: 1, factors: []}, fn x,
                                                      %{break: break, factors: factors} = acc ->
      case {rem(length, x), div(length, x)} do
        {rem, _fac} when rem === 0 and break === 1 ->
          {:cont, %{acc | break: x, factors: [x | factors]}}

        {rem, fac} when rem === 0 and fac === break ->
          {:halt, %{acc | factors: [x | factors]}}

        {rem, _fac} when rem === 0 ->
          {:cont, %{acc | factors: [x | factors]}}

        _ ->
          {:cont, acc}
      end
    end)
    |> Map.fetch!(:factors)
    |> Enum.reverse()
  end
end
