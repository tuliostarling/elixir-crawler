defmodule CrawlerChallenge.Courts.Court do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courts" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(court, attrs) do
    court
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
