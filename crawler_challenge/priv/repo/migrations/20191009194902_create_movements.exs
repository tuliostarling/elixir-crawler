defmodule CrawlerChallenge.Repo.Migrations.CreateMovements do
  use Ecto.Migration

  def change do
    create table(:movements) do
      add :movement, :text
      add :movement_date, :string

      timestamps()
    end

  end
end
