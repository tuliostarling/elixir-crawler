defmodule CrawlerChallengeWeb.SearchController do
  use CrawlerChallengeWeb, :controller

  alias CrawlerChallenge.{Courts, NebulexCache, Processes, Searches}
  alias CrawlerChallenge.Courts.Court

  def index(conn, %{"court" => court, "process_n" => process_n}) do
    with %Court{} = court <- Courts.get_court_by_name(court),
         {:ok, :valid_process_number} <- Processes.valid_process_number(process_n),
         {:invalid, nil} <- Processes.validate_date(process_n) do
      do_crawl(conn, court, process_n)
    else
      {:error, :invalid_process_number} ->
        conn
        |> put_status(401)
        |> json(%{message: "Número do processo inválido"})

      nil ->
        conn
        |> put_status(401)
        |> json(%{message: "Preencha os dados do form: Campo 'Tribunal'"})

      {:valid, process} ->
        conn
        |> put_status(:ok)
        |> json(%{data: process})
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

      NebulexCache.set_cache(process.process_number, process.id)

      conn
      |> put_status(:ok)
      |> json(%{data: process})
    else
      {:error, reason} ->
        conn
        |> put_status(401)
        |> json(%{error: reason})
    end
  end
end
