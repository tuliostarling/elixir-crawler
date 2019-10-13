defmodule CrawlerChallenge.Repo.Migrations.AddProcessIdFkToParties do
  use Ecto.Migration

  def change do
    alter table(:parties) do
      add :process_id, references(:processes, on_delete: :delete_all)
    end

    create index(:parties, [:process_id])
  end
end
