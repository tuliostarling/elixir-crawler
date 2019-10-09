defmodule CrawlerChallenge.Repo.Migrations.AddCourtIdFkToParties do
  use Ecto.Migration

  def change do
    alter table(:parties) do
      add(:court_id, references(:courts))
    end

    create(index(:parties, [:court_id]))
  end
end
