defmodule CrawlerChallenge.Repo.Migrations.CreateParties do
  use Ecto.Migration

  def change do
    create table(:parties) do
      add :partie, :string
      add :name, :string
      add :lawyer, :string

      timestamps()
    end

  end
end
