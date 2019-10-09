defmodule CrawlerChallenge.Repo.Migrations.CreateCourts do
  use Ecto.Migration

  def change do
    create table(:courts) do
      add :name, :string
      add :initials, :string

      timestamps()
    end

  end
end
