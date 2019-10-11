defmodule CrawlerChallengeWeb.ProcessController do
  use CrawlerChallengeWeb, :controller

  alias CrawlerChallenge.Processes
  alias CrawlerChallengeWeb.ProcessView

  def index(conn, _params) do
    process = Processes.get_last_process()

    conn
    |> put_view(ProcessView)
    |> render("index.json", process)
  end

  def show(conn, params) do
    render(conn, "show.html")
  end
end
