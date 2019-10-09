defmodule CrawlerChallenge.Movements.Movement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movements" do
    field :movement, :string
    field :movement_date, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(movement, attrs) do
    movement
    |> cast(attrs, [:movement, :movement_date])
    |> validate_required([:movement, :movement_date])
  end
end
