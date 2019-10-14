defmodule CrawlerChallenge.Details.Detail do
  use Ecto.Schema
  import Ecto.Changeset

  alias CrawlerChallenge.Processes

  @derive {Jason.Encoder, except: [:__meta__, :process]}
  schema "details" do
    field(:area, :string)
    field(:class, :string)
    field(:costs, :string)
    field(:control, :string)
    field(:distribution_date, :string)
    field(:judge, :string)
    field(:other_subject, :string)
    field(:other_numbers, :string)
    field(:process_number, :string)
    field(:stock_price, :string)
    field(:subject, :string)

    belongs_to(:process, Processes.Process)

    timestamps()
  end

  @optional_files ~w(costs control judge other_subject other_numbers)a
  @required_fields ~w(
    process_number
    area
    class
    distribution_date
    stock_price
    subject
    process_id
  )a

  @doc false
  def changeset(detail, attrs) do
    detail
    |> cast(attrs, @optional_files ++ @required_fields)
    |> validate_required(@required_fields)
  end
end
