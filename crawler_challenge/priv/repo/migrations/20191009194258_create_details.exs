defmodule CrawlerChallenge.Repo.Migrations.CreateDetails do
  use Ecto.Migration

  def change do
    create table(:details) do
      add :process_number, :integer
      add :class, :string
      add :area, :string
      add :subject, :string
      add :distribution_date, :naive_datetime
      add :judge, :string
      add :stock_price, :integer

      timestamps()
    end

  end
end
