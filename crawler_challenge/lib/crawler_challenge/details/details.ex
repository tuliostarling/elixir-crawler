defmodule CrawlerChallenge.Details do
  @moduledoc """
  The Details context.
  """

  import Ecto.Query, warn: false
  alias CrawlerChallenge.Repo

  alias CrawlerChallenge.Details.Detail

  @doc """
  Returns the list of details.

  ## Examples

      iex> list_details()
      [%Detail{}, ...]

  """
  def list_details do
    Repo.all(Detail)
  end

  @doc """
  Gets a single detail.

  Raises `Ecto.NoResultsError` if the Detail does not exist.

  ## Examples

      iex> get_detail!(123)
      %Detail{}

      iex> get_detail!(456)
      ** (Ecto.NoResultsError)

  """
  def get_detail!(id), do: Repo.get!(Detail, id)

  @doc """
  Creates a detail.

  ## Examples

      iex> create_detail(%{field: value})
      {:ok, %Detail{}}

      iex> create_detail(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_detail(attrs \\ %{}) do
    %Detail{}
    |> Detail.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a detail.

  ## Examples

      iex> update_detail(detail, %{field: new_value})
      {:ok, %Detail{}}

      iex> update_detail(detail, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_detail(%Detail{} = detail, attrs) do
    detail
    |> Detail.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Detail.

  ## Examples

      iex> delete_detail(detail)
      {:ok, %Detail{}}

      iex> delete_detail(detail)
      {:error, %Ecto.Changeset{}}

  """
  def delete_detail(%Detail{} = detail) do
    Repo.delete(detail)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking detail changes.

  ## Examples

      iex> change_detail(detail)
      %Ecto.Changeset{source: %Detail{}}

  """
  def change_detail(%Detail{} = detail) do
    Detail.changeset(detail, %{})
  end
end
