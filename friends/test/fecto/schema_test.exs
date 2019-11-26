defmodule FEctoTest do
  use ExUnit.Case

  defmodule Person do
    use FEcto.Schema

    schema "people" do
      field :first_name, :string
      field :last_name, :string
      field :age, :integer
    end
  end

  test "hello" do
    assert true
  end
end
