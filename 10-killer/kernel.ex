defmodule Test do

  def test(v) when elem(v, 1) > 2 do
    "ping"
  end

  def test(_) do
    "pong"
  end

end
