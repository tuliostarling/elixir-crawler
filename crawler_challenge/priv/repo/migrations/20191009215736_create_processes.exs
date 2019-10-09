defmodule CrawlerChallenge.Repo.Migrations.CreateProcesses do
  use Ecto.Migration

  def change do
    create table(:processes) do
      add :process_number, :integer

      timestamps()
    end

  end
end
