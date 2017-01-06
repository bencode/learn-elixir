defmodule Cashy.Bug2 do
  def covert(:sgd, :usd, amount) do
    {:ok, amount * 0.7}
  end


  def covert(_, _, _) do
    {:error, :invalid_format}
  end


  def run(amount) do
    case covert(:sgd, :usd, amount) do
      {:ok, amount} ->
        IO.puts "convert amount is #{amount}"

      {:error, reason} ->
        IO.puts "whoops, #{String.to_atom(reason)}"
    end
  end
end
