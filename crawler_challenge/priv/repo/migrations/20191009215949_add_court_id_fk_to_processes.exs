defmodule CrawlerChallenge.Repo.Migrations.AddCourtIdFkToProcesses do
  use Ecto.Migration

  def change do
    alter table(:processes) do
      add :court_id, references(:courts)
    end

    create index(:processes, [:court_id])
  end
end
