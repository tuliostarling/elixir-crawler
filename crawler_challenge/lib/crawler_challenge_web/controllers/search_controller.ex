defmodule CrawlerChallengeWeb.SearchController do
  use CrawlerChallengeWeb, :controller

  alias CrawlerChallenge.{Processes, Searches}

  alias CrawlerChallengeWeb.ProcessView

  def index(conn, %{"court" => court, "process_n" => process_n}) do
    process_data = Processes.get_process_by_number(process_n)

    case Processes.validate_date(process_data) do
      {:invalid, nil} ->
        do_crawl(conn, court, process_n)

      {:valid, process} ->
        conn
        |> put_status(:ok)
        |> render(ProcessView, :index, %{process: process})
    end
  end

  def do_crawl(conn, court, process_n) do
    with {:ok, show_url} <- Searches.return_show_url(process_n),
         {:ok, body} <- Searches.get_html_body(show_url),
         {:ok, crawled_data} <- Searches.get_crawled_data(body),
         {:ok, %{process: process}} <-
           Processes.insert_all_data(process_n, court, crawled_data) do
      process =
        Processes.get_process_by_id_and_preload(
          process,
          [:details, :movements, :parties, :court]
        )

      conn
      |> put_status(:ok)
      |> render(ProcessView, :index, %{process: process})
    else
      {:error, reason} ->
        {:error, reason}
    end
  end
end
