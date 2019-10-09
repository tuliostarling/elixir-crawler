defmodule CrawlerChallenge.Repo.Migrations.AddCourtIdFkToMovements do
  use Ecto.Migration

  def change do
    alter table(:movements) do
      add(:court_id, references(:courts))
    end

    create(index(:movements, [:court_id]))
  end
end
