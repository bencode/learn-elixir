defmodule GCD do
  # 对于a > b > 0 有复杂度为O(lg(b))
  def gcd(a, 0), do: a
  def gcd(a, b) do
    gcd(b, rem(a, b))
  end


  def egcd(a, 0), do: [{a, a, 0, 1, 0}]
  def egcd(a, b) do
    list = egcd(b, rem(a, b))
    [{d, _a, _b, x, y} | _] = list
    [{d, a, b, y, x - div(a, b) * y} | list]
  end
end
