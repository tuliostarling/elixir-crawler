defmodule CrawlerChallenge.Repo.Migrations.AddCourtIdFkToDetails do
  use Ecto.Migration

  def change do
    alter table(:details) do
      add :court_id, references(:courts)
    end

    create index(:details, [:court_id])
  end
end
