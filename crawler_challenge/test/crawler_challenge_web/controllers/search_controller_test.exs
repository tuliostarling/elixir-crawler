defmodule CrawlerChallengeWeb.SearchControllerTest do
  use CrawlerChallengeWeb.ConnCase, async: true

  alias CrawlerChallengeWeb.SearchController

  describe "index/2" do
    test "returns {:valid, process} and render a json", %{conn: conn} do
      court = insert(:courts)
      process = insert(:valid_process, court: court)

      params = %{"court" => court.name, "process_n" => process.process_number}

      conn = post(conn, Routes.search_path(conn, :index, params))

      assert json_response(conn, 200)
    end

    test "returns {:invalid, nil} crawl and render a json", %{conn: conn} do
      court = insert(:courts)
      process = insert(:invalid_process, court: court)

      params = %{"court" => court.name, "process_n" => process.process_number}

      conn = post(conn, Routes.search_path(conn, :index, params))

      assert json_response(conn, 200)
    end
  end

  describe "do_crawl/3" do
    test "crawl and render a json", %{conn: conn} do
      court = insert(:courts)
      process = insert(:process, court: court)

      conn = SearchController.do_crawl(conn, court, process.process_number)

      assert json_response(conn, 200)
    end
  end
end
