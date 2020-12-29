defmodule PI.Test do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO, only: [capture_io: 1]

  use PI

  test "inspect with module, func, file & line number" do
    object = %{some: "value", barcode: 123}
    timestamp = PI.timestamp() |> String.replace(~r/\d{2}:\d{2}$/, "00:00")

    expected =
      "\n#{timestamp} \e[33m[test/pi_test.exs:#{__ENV__.line + 4}: PI.Test.test inspect with module, func, file & line number/1]\n\e[1m\e[37m\e[48;5;18mPI Label\e[0m: \e[93m%{\e[0m\e[36mbarcode:\e[0m \e[31m123\e[0m\e[93m,\e[0m \e[36msome:\e[0m \e[32m\"value\"\e[0m\e[93m}\e[0m\n"

    result =
      capture_io(fn ->
        assert pi(object, "PI Label") == object
      end)
      |> String.replace(~r/^(\n\d{2}:)\d{2}:\d{2} /, "\\g{1}00:00 ")

    assert result == expected
  end
end
