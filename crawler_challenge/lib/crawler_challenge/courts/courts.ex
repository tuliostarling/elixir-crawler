defmodule CrawlerChallenge.Courts do
  @moduledoc """
  The Courts context.
  """

  import Ecto.Query, warn: false
  alias CrawlerChallenge.Repo

  alias CrawlerChallenge.Courts.Court

  @doc """
  Returns the list of courts.

  ## Examples

      iex> list_courts()
      [%Court{}, ...]

  """
  def list_courts do
    Repo.all(Court)
  end

  @doc """
  Gets a single court.

  Raises `Ecto.NoResultsError` if the Court does not exist.

  ## Examples

      iex> get_court!(123)
      %Court{}

      iex> get_court!(456)
      ** (Ecto.NoResultsError)

  """
  def get_court!(id), do: Repo.get!(Court, id)

  @doc """
  Creates a court.

  ## Examples

      iex> create_court(%{field: value})
      {:ok, %Court{}}

      iex> create_court(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_court(attrs \\ %{}) do
    %Court{}
    |> Court.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a court.

  ## Examples

      iex> update_court(court, %{field: new_value})
      {:ok, %Court{}}

      iex> update_court(court, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_court(%Court{} = court, attrs) do
    court
    |> Court.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Court.

  ## Examples

      iex> delete_court(court)
      {:ok, %Court{}}

      iex> delete_court(court)
      {:error, %Ecto.Changeset{}}

  """
  def delete_court(%Court{} = court) do
    Repo.delete(court)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking court changes.

  ## Examples

      iex> change_court(court)
      %Ecto.Changeset{source: %Court{}}

  """
  def change_court(%Court{} = court) do
    Court.changeset(court, %{})
  end
end
