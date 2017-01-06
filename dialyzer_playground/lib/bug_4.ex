defmodule Cashy.Bug4 do
  def convert(:sgd, :usd, amount) do
    {:ok, amount * 0.7}
  end


  def amount({:value, value}) do
    value
  end


  def run do
    convert(:sgd, :usd, amount({:value, :one_million_dollors}))
  end
end
