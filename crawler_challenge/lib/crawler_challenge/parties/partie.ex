defmodule CrawlerChallenge.Parties.Partie do
  use Ecto.Schema
  import Ecto.Changeset

  alias CrawlerChallenge.Processes

  schema "parties" do
    field :lawyer, :string
    field :name, :string
    field :partie, :string

    belongs_to :process, Processes.Process

    timestamps()
  end

  @required_fields ~w(lawyer name partie process_id)a

  @doc false
  def changeset(partie, attrs) do
    partie
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
