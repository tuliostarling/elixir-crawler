defmodule CrawlerChallenge.Parties do
  @moduledoc """
  The Parties context.
  """

  import Ecto.Query, warn: false
  alias CrawlerChallenge.Repo

  alias CrawlerChallenge.Parties.Partie

  @doc """
  Returns the list of parties.

  ## Examples

      iex> list_parties()
      [%Partie{}, ...]

  """
  def list_parties do
    Repo.all(Partie)
  end

  @doc """
  Gets a single partie.

  Raises `Ecto.NoResultsError` if the Partie does not exist.

  ## Examples

      iex> get_partie!(123)
      %Partie{}

      iex> get_partie!(456)
      ** (Ecto.NoResultsError)

  """
  def get_partie!(id), do: Repo.get!(Partie, id)

  @doc """
  Creates a partie.

  ## Examples

      iex> create_partie(%{field: value})
      {:ok, %Partie{}}

      iex> create_partie(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_partie(attrs \\ %{}) do
    %Partie{}
    |> Partie.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a partie.

  ## Examples

      iex> update_partie(partie, %{field: new_value})
      {:ok, %Partie{}}

      iex> update_partie(partie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_partie(%Partie{} = partie, attrs) do
    partie
    |> Partie.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Partie.

  ## Examples

      iex> delete_partie(partie)
      {:ok, %Partie{}}

      iex> delete_partie(partie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_partie(%Partie{} = partie) do
    Repo.delete(partie)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking partie changes.

  ## Examples

      iex> change_partie(partie)
      %Ecto.Changeset{source: %Partie{}}

  """
  def change_partie(%Partie{} = partie) do
    Partie.changeset(partie, %{})
  end
end
