defmodule CrawlerChallenge.Movements.Movement do
  use Ecto.Schema
  import Ecto.Changeset

  alias CrawlerChallenge.Processes

  schema "movements" do
    field(:movement, :string)
    field(:movement_date, :string)

    belongs_to(:process, Processes.Process)

    timestamps()
  end

  @required_fields ~w(movement movement_date process_id)a

  @doc false
  def changeset(movement, attrs) do
    movement
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
