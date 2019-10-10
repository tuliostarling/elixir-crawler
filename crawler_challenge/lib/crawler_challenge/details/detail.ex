defmodule CrawlerChallenge.Details.Detail do
  use Ecto.Schema
  import Ecto.Changeset

  alias CrawlerChallenge.Processes

  schema "details" do
    field :area, :string
    field :class, :string
    field :distribution_date, :string
    field :judge, :string
    field :stock_price, :string
    field :subject, :string

    belongs_to :process, Processes.Process

    timestamps()
  end

  @required_fields ~w(area class distribution_date judge stock_price subject process_id)a

  @doc false
  def changeset(detail, attrs) do
    detail
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
