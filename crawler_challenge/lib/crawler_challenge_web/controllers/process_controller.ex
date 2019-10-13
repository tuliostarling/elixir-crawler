defmodule CrawlerChallengeWeb.ProcessController do
  use CrawlerChallengeWeb, :controller

  alias CrawlerChallenge.Processes

  plug(:set_process when action == :index)

  def index(%{assigns: %{process: process}} = conn, _params) do
    render(conn, "index.html", %{process: process})
  end

  def set_process(conn, _params) do
    process = Processes.get_last_process_and_preload([:details, :movements, :parties, :court])

    case process do
      nil -> assign(conn, :process, nil)
      _ -> assign(conn, :process, process)
    end
  end
end
