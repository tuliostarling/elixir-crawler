defmodule CrawlerChallenge.Processes do
  @moduledoc """
  The Processes context.
  """

  use Timex

  import Ecto.Query, warn: false
  alias CrawlerChallenge.{Courts, Details, Movements, Parties}
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

  def get_process_by_id_and_preload(%{id: id}, associations) do
    Process
    |> Repo.get!(id)
    |> Repo.preload(associations)
  end

  def validate_date(process) do
    case process do
      nil -> {:invalid, nil}
      data -> check_expiration(data)
    end
  end

  def valid_process_number(""), do: {:error, :invalid_process_number}

  def valid_process_number(process_n) do
    case String.match?(process_n, ~r/[a-zA-Z]/) do
      true -> {:error, :invalid_process_number}
      false -> {:ok, :valid_process_number}
    end
  end

  def check_expiration(%{inserted_at: date} = data) do
    %{until: until} = Interval.new(from: date, until: [hours: 24])
    {:ok, date_time} = DateTime.from_naive(until, "Etc/UTC")

    result = Timex.diff(date_time, DateTime.utc_now(), :hours)

    case result > 0 do
      true ->
        {:valid, Repo.preload(data, [:details, :movements, :parties, :court])}

      false ->
        {:ok, _result} = delete_process(data)
        {:invalid, nil}
    end
  end

  def get_last_process_and_preload(associations) do
    query = from(p in Process, order_by: [desc: p.id], limit: 1)

    query
    |> Repo.one()
    |> Repo.preload(associations)
  end

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

  def insert_all_data(process, court, crawled_data) do
    %{id: court_id} = Courts.get_court_by_name(court.name)
    process_params = %{"process_number" => process, "court_id" => court_id}

    Multi.new()
    |> Multi.insert(:process, Process.changeset(%Process{}, process_params))
    |> Movements.insert_movement_by_multi(crawled_data[:list_movements])
    |> Parties.insert_parties_by_multi(crawled_data[:list_parties])
    |> Details.insert_details_by_multi(crawled_data[:list_details])
    |> Repo.transaction()
    |> case do
      {:ok, result} -> {:ok, result}
      {:error, _module, reason} -> {:error, reason}
    end
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
