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

  @required_fields ~w(name partie process_id)a
  @optional_fields ~w(position person_name_position)a

  @doc false
  def changeset(partie, attrs) do
    partie
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
