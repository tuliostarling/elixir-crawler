defmodule CrawlerChallengeWeb.SearchControllerTest do
  use CrawlerChallengeWeb.ConnCase, async: false

  alias CrawlerChallengeWeb.SearchController

  describe "index/2" do
    test "returns {:valid, process} and render a json", %{conn: conn} do
      court = insert(:courts)
      process = insert(:another_process, court: court)

      params = %{"court" => court.name, "process_n" => process.process_number}

      conn = post(conn, Routes.search_path(conn, :index, params))

      assert json_response(conn, 200)
    end

    test "returns {:invalid, nil} with a non existing process_number in db, crawl and render a json",
         %{conn: conn} do
      court = insert(:courts)

      params = %{"court" => court.name, "process_n" => "0000214-28.2011.8.02.0081"}

      conn = post(conn, Routes.search_path(conn, :index, params))

      assert json_response(conn, 200)
    end

    test "returns {:error, :invalid_process_number} with a invalid process_number", %{conn: conn} do
      court = insert(:courts)

      params = %{"court" => court.name, "process_n" => "0000twi-28.nnnn.8.02.0081"}

      conn = post(conn, Routes.search_path(conn, :index, params))

      assert json_response(conn, 401)
      assert %{"message" => "Número do processo inválido"} = json_response(conn, 401)
    end

    test "returns nil when court doesnt exists ", %{conn: conn} do
      params = %{"court" => "", "process_n" => "0717561-98.2019.8.02.0001"}

      conn = post(conn, Routes.search_path(conn, :index, params))

      assert json_response(conn, 401)

      assert %{"message" => "Preencha os dados do form: Campo 'Tribunal'"} =
               json_response(conn, 401)
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
