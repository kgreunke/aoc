defmodule Aoc.Y2025.Day1Test do
  use ExUnit.Case

  alias Aoc.Day1

  test "Rotatate right" do
    assert Day1.rotate("R9", {0, 0, 0}) === {9, 0, 0}
  end

  test "Rotate left" do
    assert Day1.rotate("L9", {0, 0, 0}) === {91, 0, 0}
  end

  test "Rotate right past 100" do
    assert Day1.rotate("R150", {0, 0, 0}) === {50, 0, 1}
    assert Day1.rotate("R876", {14, 0, 0}) === {90, 0, 8}
  end

  test "Rotate left past 100" do
    assert Day1.rotate("L150", {0, 0, 0}) === {50, 0, 1}
    assert Day1.rotate("L567", {97, 0, 0}) === {30, 0, 5}
  end

  test "Offset rotate right past 100" do
    assert Day1.rotate("R75", {50, 0, 0}) === {25, 0, 1}
  end

  test "Offset rotate left past 100" do
    assert Day1.rotate("L95", {5, 0, 0}) === {10, 0, 1}
  end

  test "Rotate left to zero" do
    assert Day1.rotate("L5", {5, 0, 0}) === {0, 1, 1}
  end

  test "Rotate right to zero" do
    assert Day1.rotate("R5", {95, 0, 0}) === {0, 1, 1}
  end

  test "Rotate right past 100 to 0" do
    assert Day1.rotate("R280", {20, 0, 0}) === {0, 1, 3}
  end

  test "Rotate left past 100 to 0" do
    assert Day1.rotate("L280", {80, 0, 0}) === {0, 1, 3}
  end
end
