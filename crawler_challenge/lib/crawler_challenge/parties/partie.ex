defmodule CrawlerChallenge.Parties.Partie do
  use Ecto.Schema
  import Ecto.Changeset

  alias CrawlerChallenge.Processes

  @derive {Jason.Encoder, except: [:__meta__, :process]}
  schema "parties" do
    field(:person_name_position, :string)
    field(:position, :string)
    field(:name, :string)
    field(:partie, :string)

    belongs_to(:process, Processes.Process)

    timestamps()
  end

  @optional_fields ~w(name partie position person_name_position)a
  @required_fields ~w(process_id)a

  @doc false
  def changeset(partie, attrs) do
    partie
    |> cast(attrs, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
  end
end
