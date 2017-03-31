defmodule FpTest do
  use ExUnit.Case
  alias Fp.Container


  test "of" do
    Container.of(3)

    %{name: "yoda"}
    |> Container.of
    |> Container.of
  end
end
