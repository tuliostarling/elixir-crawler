defmodule CrawlerChallenge.Movements do
  @moduledoc """
  The Movements context.
  """

  use Timex

  import Ecto.Query, warn: false
  alias CrawlerChallenge.Repo

  alias CrawlerChallenge.Movements.Movement

  alias Ecto.Multi

  @doc """
  Returns the list of movements.

  ## Examples

      iex> list_movements()
      [%Movement{}, ...]

  """
  def list_movements do
    Repo.all(Movement)
  end

  @doc """
  Gets a single movement.

  Raises `Ecto.NoResultsError` if the Movement does not exist.

  ## Examples

      iex> get_movement!(123)
      %Movement{}

      iex> get_movement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_movement!(id), do: Repo.get!(Movement, id)

  @doc """
  Creates a movement.

  ## Examples

      iex> create_movement(%{field: value})
      {:ok, %Movement{}}

      iex> create_movement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_movement(attrs \\ %{}) do
    %Movement{}
    |> Movement.changeset(attrs)
    |> Repo.insert()
  end

  def insert_movement_by_multi(multi, attrs) do
    multi
    |> Multi.run(:movement, fn _repo, %{process: process} ->
      movement_params =
        Enum.map(attrs, fn movement ->
          movement
          |> Map.put(:inserted_at, Timex.now())
          |> Map.put(:updated_at, Timex.now())
          |> Map.merge(%{"process_id" => process.id})
        end)

      {count, _} = Repo.insert_all("movements", movement_params)
      {:ok, count}
    end)
  end

  @doc """
  Updates a movement.

  ## Examples

      iex> update_movement(movement, %{field: new_value})
      {:ok, %Movement{}}

      iex> update_movement(movement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_movement(%Movement{} = movement, attrs) do
    movement
    |> Movement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Movement.

  ## Examples

      iex> delete_movement(movement)
      {:ok, %Movement{}}

      iex> delete_movement(movement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_movement(%Movement{} = movement) do
    Repo.delete(movement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking movement changes.

  ## Examples

      iex> change_movement(movement)
      %Ecto.Changeset{source: %Movement{}}

  """
  def change_movement(%Movement{} = movement) do
    Movement.changeset(movement, %{})
  end
end
