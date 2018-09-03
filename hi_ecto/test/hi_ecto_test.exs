defmodule HiEctoTest do
  use ExUnit.Case
  doctest HiEcto

  alias HiEcto.Repo

  defmodule Category do
    use Ecto.Schema
    schema "categories" do
      field :name
    end
  end

  defmodule Product do
    use Ecto.Schema
    schema "products" do
      field :name
      field :body
      field :price, :float
      field :available, :boolean
      belongs_to :category, Category
    end
  end

  defmodule Variant do
    use Ecto.Schema
    schema "variants" do
      field :name
      field :price, :float
      belongs_to :product, Product
    end
  end

  test "simple" do
    product = %Product{
      name: "Learn Elixir",
      body: "learn elixir day by day",
      price: 1.11,
      available: true
    }
    product = Repo.insert!(product)

    assert product.id != nil

    product2 = Repo.get!(Product, product.id)
    assert product == product2

    Repo.delete!(product2)
  end
end
