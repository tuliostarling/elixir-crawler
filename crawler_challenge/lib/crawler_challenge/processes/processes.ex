defmodule CrawlerChallenge.Processes do
  @moduledoc """
  The Processes context.
  """

  import Ecto.Query, warn: false
  alias CrawlerChallenge.Courts
  alias CrawlerChallenge.Repo

  alias CrawlerChallenge.Processes.Process

  alias Ecto.Multi

  @doc """
  Returns the list of processes.

  ## Examples

      iex> list_processes()
      [%Process{}, ...]

  """
  def list_processes do
    Repo.all(Process)
  end

  @doc """
  Gets a single process.

  Raises `Ecto.NoResultsError` if the Process does not exist.

  ## Examples

      iex> get_process!(123)
      %Process{}

      iex> get_process!(456)
      ** (Ecto.NoResultsError)

  """
  def get_process!(id), do: Repo.get!(Process, id)

  def get_process_by_number(number), do: Repo.get_by(Process, process_number: number)

  def get_last_process, do: Repo.one(from p in Process, order_by: [desc: p.id], limit: 1)

  @doc """
  Creates a process.

  ## Examples

      iex> create_process(%{field: value})
      {:ok, %Process{}}

      iex> create_process(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_process(attrs \\ %{}) do
    %Process{}
    |> Process.changeset(attrs)
    |> Repo.insert()
  end

  def insert_process_by_multi(process, court) do
    %{id: court_id} = Courts.get_court_by_name(court)
    process_params = %{"process_number" => process, "court_id" => court_id}

    Multi.new()
    |> Multi.insert(:process, Process.changeset(%Process{}, process_params))
  end

  @doc """
  Updates a process.

  ## Examples

      iex> update_process(process, %{field: new_value})
      {:ok, %Process{}}

      iex> update_process(process, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_process(%Process{} = process, attrs) do
    process
    |> Process.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Process.

  ## Examples

      iex> delete_process(process)
      {:ok, %Process{}}

      iex> delete_process(process)
      {:error, %Ecto.Changeset{}}

  """
  def delete_process(%Process{} = process) do
    Repo.delete(process)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking process changes.

  ## Examples

      iex> change_process(process)
      %Ecto.Changeset{source: %Process{}}

  """
  def change_process(%Process{} = process) do
    Process.changeset(process, %{})
  end
end
