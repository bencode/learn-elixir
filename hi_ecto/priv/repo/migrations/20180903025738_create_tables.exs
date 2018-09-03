defmodule HiEcto.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
    end

    create table(:products) do
      add :name, :string
      add :body, :text
      add :price, :float
      add :available, :boolean
      add :category_id, references(:categories)
    end

    create table(:variants) do
      add :name, :string
      add :price, :float
      add :product_id, references(:products)
    end
  end
end
