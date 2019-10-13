defmodule CrawlerChallenge.Repo.Migrations.CreateDetails do
  use Ecto.Migration

  def change do
    create table(:details) do
      add :process_number, :string
      add :class, :string
      add :costs, :string
      add :control, :string
      add :area, :string
      add :subject, :string
      add :other_subject, :string
      add :other_numbers, :string
      add :distribution_date, :string
      add :judge, :string
      add :stock_price, :string

      timestamps()
    end
  end
end
