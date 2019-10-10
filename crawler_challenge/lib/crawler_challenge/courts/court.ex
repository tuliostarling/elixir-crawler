defmodule CrawlerChallenge.Courts.Court do
  use Ecto.Schema
  import Ecto.Changeset

  alias CrawlerChallenge.Processes

  schema "courts" do
    field :name, :string
    field :initials, :string

    has_many :processes, Processes.Process

    timestamps()
  end

  @required_fields ~w(name initials)a

  @doc false
  def changeset(court, attrs) do
    court
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
