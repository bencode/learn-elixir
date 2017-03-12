defmodule GCD do
  def gcd(a, 0), do: a
  def gcd(a, b) do
    gcd(b, rem(a, b))
  end
end
