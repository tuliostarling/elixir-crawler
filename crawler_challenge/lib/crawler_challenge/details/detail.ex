defmodule CrawlerChallenge.Details.Detail do
  use Ecto.Schema
  import Ecto.Changeset

  alias CrawlerChallenge.Processes

  schema "details" do
    field(:area, :string)
    field(:class, :string)
    field(:control, :string)
    field(:distribution_date, :string)
    field(:judge, :string)
    field(:other_subject, :string)
    field(:process_number)
    field(:stock_price, :string)
    field(:subject, :string)

    belongs_to(:process, Processes.Process)

    timestamps()
  end

  @optional_files ~w(control other_subject)a
  @required_fields ~w(process_number area class distribution_date judge stock_price subject other_subject process_id)a

  @doc false
  def changeset(detail, attrs) do
    detail
    |> cast(attrs, @optional_files ++ @required_fields)
    |> validate_required(@required_fields)
  end
end
