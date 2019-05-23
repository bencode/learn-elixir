defmodule HelloEexTest do
  use ExUnit.Case
  doctest HelloEex


  defmodule Template do
    @tpl """
    <%= a + b %>
    """

    require EEx
    EEx.function_from_string(:def, :add, @tpl, [:a, :b])
  end

  test "run" do
    s = Template.add(1, 2)
    assert s == "3\n"
  end


end
