defmodule TrailRunnerTest do
  use ExUnit.Case
  doctest TrailRunner

  test "greets the world" do
    assert TrailRunner.hello() == :world
  end

  test "miles in generated schedule add up to mpw (Miles Per Week)" do
    program = TrailRunner.Program.new()
    expected_miles = program |> Map.get(:mpw)
    actual_miles = program
        |> TrailRunner.Program.generate_schedule()
        |> Enum.map(&(Map.get(&1, :miles)))
        |> Enum.reduce(&(&1 + &2))

    assert expected_miles == actual_miles
  end
end
