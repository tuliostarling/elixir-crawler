defmodule CrawlerChallenge.Repo.Migrations.AddProcessIdFkToMovements do
  use Ecto.Migration

  def change do
    alter table(:movements) do
      add :process_id, references(:processes, on_delete: :delete_all)
    end

    create index(:movements, [:process_id])
  end
end
