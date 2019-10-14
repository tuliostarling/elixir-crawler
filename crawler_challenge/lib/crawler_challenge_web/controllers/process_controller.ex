defmodule CrawlerChallengeWeb.ProcessController do
  use CrawlerChallengeWeb, :controller

  alias CrawlerChallenge.Processes

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
