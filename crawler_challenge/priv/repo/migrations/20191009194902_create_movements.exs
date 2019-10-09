defmodule CrawlerChallenge.Repo.Migrations.CreateMovements do
  use Ecto.Migration

  def change do
    create table(:movements) do
      add :movement, :string
      add :movement_date, :naive_datetime

      timestamps()
    end

  end
end
