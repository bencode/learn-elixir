defmodule GCDTest do
  use ExUnit.Case, async: true
  import GCD


  test "gcd(a, b)" do
    assert gcd(6, 9) == 3
    assert gcd(7, 0) == 7
    assert gcd(0, 7) == 7
    assert gcd(3, 9) == 3
    assert gcd(12345, 4567890) == 15
  end


  test "egcd(a, b)" do
    IO.inspect egcd(99, 78)
  end
end
