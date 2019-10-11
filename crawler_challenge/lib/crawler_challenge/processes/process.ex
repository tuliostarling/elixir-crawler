defmodule CrawlerChallenge.Processes.Process do
  use Ecto.Schema
  import Ecto.Changeset

  alias CrawlerChallenge.{Courts, Details, Movements, Parties}

  schema "processes" do
    field(:process_number, :string)

    belongs_to(:court, Courts.Court)
    has_many(:details, Details.Detail)
    has_many(:movements, Movements.Movement)
    has_many(:parties, Parties.Partie)

    timestamps()
  end

  @required_fields ~w(process_number court_id)a

  @doc false
  def changeset(process, attrs) do
    process
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
