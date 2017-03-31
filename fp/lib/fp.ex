defmodule Fp do
  defmodule Container do
    defstruct value: nil


    def of(value) do
      %Container{value: value}
    end


    def map(f) do
    end
  end
end
