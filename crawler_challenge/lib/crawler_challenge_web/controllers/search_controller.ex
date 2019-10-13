defmodule CrawlerChallengeWeb.SearchController do
  use CrawlerChallengeWeb, :controller

  alias CrawlerChallenge.{Details, Movements, Parties, Processes, Repo, Searches}

  alias CrawlerChallengeWeb.ProcessView

  def index(conn, %{"court" => court, "process_n" => process_n}) do
    with {:ok, show_url} <- Searches.return_show_url(process_n),
         {:ok, body} <- Searches.get_html_body(show_url),
         {:ok, crawled_data} <- Searches.get_crawled_data(body),
         {:ok, %{process: process}} <- insert_all_data(process_n, court, crawled_data) do
      process =
        Processes.get_process_by_id_and_preload(process, [:details, :movements, :parties, :court])

      conn
      |> render(ProcessView, :index, %{process: process})
    else
      {:error, reason} ->
        {:error, reason}
    end
  end

  def insert_all_data(process, court, crawled_data) do
    process
    |> Processes.insert_process_by_multi(court)
    |> Movements.insert_movement_by_multi(crawled_data[:list_movements])
    |> Parties.insert_parties_by_multi(crawled_data[:list_parties])
    |> Details.insert_details_by_multi(crawled_data[:list_details])
    |> Repo.transaction()
    |> case do
      {:ok, result} -> {:ok, result}
      {:error, _module, reason} -> {:error, reason}
    end
  end
end
