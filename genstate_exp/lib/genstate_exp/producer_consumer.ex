defmodule GenstateExp.ProducerConsumer do
  use GenStage
  require Integer

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter, name: __MODULE__)
  end

  def init(state) do
    {:producer_consumer, state, subscribe_to: [GenstateExp.Producer]}
  end

  def handle_events(events, _from, state) do
    nums = events |> Enum.filter(&Integer.is_even/1)
    {:noreply, nums, state}
  end
end
