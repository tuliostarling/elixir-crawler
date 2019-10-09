defmodule CrawlerChallenge.Parties.Partie do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parties" do
    field :lawyer, :string
    field :name, :string
    field :partie, :string

    timestamps()
  end

  @doc false
  def changeset(partie, attrs) do
    partie
    |> cast(attrs, [:partie, :name, :lawyer])
    |> validate_required([:partie, :name, :lawyer])
  end
end
