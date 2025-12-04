defmodule Aoc.Y2025.Day2Test do
  use ExUnit.Case

  alias Aoc.Y2025.Day2

  test "check 2 digit ID" do
    assert Day2.check_id("11") === 11
  end

  test "check id with leading 0" do
    assert Day2.check_id("0101") === 0
  end

  test "check valid id" do
    assert Day2.check_id("1023") === 0
  end

  test "check 4 digit ID" do
    assert Day2.check_id("1313") === 1313
  end

  test "reducer function" do
    assert Day2.check_id("11", 0) === 11
  end

  test "stage 2 check multi matches" do
    assert Day2.check_id(123_123_123, [1, 3, 9]) === 123_123_123
    refute Day2.check_id(10_051_111, [1, 2, 4]) === 10_051_111
  end

  test "String to range" do
    assert Day2.rangeify_ranges("111-222") == Range.to_list(111..222)
  end

  test "factorize number but only keep only the first half of the factors" do
    assert Day2.factorize(12) === [1, 2, 3, 4, 6]
  end

  test "factorize number that can't be divisible by 2" do
    assert Day2.factorize(9) === [1, 3, 9]
  end
end
