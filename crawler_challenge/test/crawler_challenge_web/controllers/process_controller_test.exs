defmodule CrawlerChallengeWeb.ProcessControllerTest do
  use CrawlerChallengeWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "CrawlerChallenge"
  end
end
