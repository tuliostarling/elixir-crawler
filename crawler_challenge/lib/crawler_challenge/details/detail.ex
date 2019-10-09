defmodule CrawlerChallenge.Details.Detail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "details" do
    field :area, :string
    field :class, :string
    field :distribution_date, :naive_datetime
    field :judge, :string
    field :process_number, :integer
    field :stock_price, :integer
    field :subject, :string

    timestamps()
  end

  @doc false
  def changeset(detail, attrs) do
    detail
    |> cast(attrs, [:process_number, :class, :area, :subject, :distribution_date, :judge, :stock_price])
    |> validate_required([:process_number, :class, :area, :subject, :distribution_date, :judge, :stock_price])
  end
end
