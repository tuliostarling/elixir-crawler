defmodule CrawlerChallenge.Repo.Migrations.CreateDetails do
  use Ecto.Migration

  def change do
    create table(:details) do
      add :class, :string
      add :area, :string
      add :subject, :string
      add :distribution_date, :string
      add :judge, :string
      add :stock_price, :string

      timestamps()
    end

  end
end
