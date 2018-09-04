defmodule HiEctoTest do
  use ExUnit.Case
  doctest HiEcto

  import Ecto.Query
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

  # test "simple" do
  #   product = %Product{
  #     name: "Learn Elixir",
  #     body: "learn elixir day by day",
  #     price: 1.11,
  #     available: true
  #   }
  #   product = Repo.insert!(product)

  #   assert product.id != nil

  #   product2 = Repo.get!(Product, product.id)
  #   assert product == product2

  #   Repo.delete!(product2)
  # end

  # test "join" do
  #   name = "%Elixir%"
  #   query = from v in Variant,
  #     join: p in assoc(v, :product),
  #     join: c in assoc(p, :category),
  #     where: (like(v.name, ^name) and like(c.name, ^name)) or (like(p.name, ^name) and like(c.name, ^name))
  #   list = Repo.all(query)
  #   IO.inspect list
  # end

  test "expr" do
    name = "%Elixir%"
    expr = "product.category.name and name or product.category.name and category.name and (product.name or product.body) like"

    rule = HiEcto.QueryBuilder.parse(expr)
    assert rule == %{
      expr: {:or,
             {:and,
              {:selector,
               %{field: "name", joins: [:product, :category], namespace: "category"}},
              {:selector, %{field: "name", joins: [], namespace: nil}}},
             {:and,
              {:selector,
               %{field: "name", joins: [:product, :category], namespace: "category"}},
              {:and,
               {:selector, %{field: "name", joins: [:category], namespace: "category"}},
               {:or,
                {:selector, %{field: "name", joins: [:product], namespace: "product"}},
                {:selector, %{field: "body", joins: [:product], namespace: "product"}}}}}},
      fun: "like"
    }

    query = HiEcto.QueryBuilder.build(Variant, expr, "%Elixir%")
    list = Repo.all(query)
  end
end
