defmodule Cashy.Bug1 do
  def covert(:sgd, :usd, amount) do
    {:ok, amount * 0.7}
  end


  def run do
    covert(:sgd, :usd, :one_million_dollars)
  end
end
