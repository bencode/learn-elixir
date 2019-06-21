defmodule MyList do
  def sum(list) do
    list |> Enum.reduce(0, &(&1 + &2))
  end
end

defmodule OtherList do
  defdelegate sum(list), to: MyList
end
