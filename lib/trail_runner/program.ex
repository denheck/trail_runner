defmodule TrailRunner.Program do
  @moduledoc false

  defstruct [
    mpw: 10, # Miles Per Week
    increase_rate: 0.10,
    start_date: Date.utc_today(),
    weeks: 1,
    schedule: []
  ]

  def new do
    %__MODULE__{}
  end

  def generate_schedule(program) do
    1..program.weeks
    |> Enum.reduce(program, &generate_week/2)
    |> Map.get(:schedule)
  end

  defp generate_week(week, program = %__MODULE__{ start_date: start_date, mpw: mpw, schedule: schedule, increase_rate: increase_rate }) do
    week_start = Date.add(start_date, (week - 1) * 7)
    days = [
      %{ day: Date.add(week_start, 1), miles: 0.15 * mpw },
      %{ day: Date.add(week_start, 2), miles: 0.2 * mpw },
      %{ day: Date.add(week_start, 3), miles: 0.15 * mpw },
      %{ day: Date.add(week_start, 5), miles: 0.40 * mpw },
      %{ day: Date.add(week_start, 6), miles: 0.10 * mpw },
    ]

    %__MODULE__{ program | schedule: schedule ++ days, mpw: mpw + (mpw * increase_rate)}
  end
end
