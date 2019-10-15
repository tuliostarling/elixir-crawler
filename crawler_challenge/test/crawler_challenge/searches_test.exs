defmodule CrawlerChallenge.SearchesTest do
  use CrawlerChallenge.DataCase

  alias CrawlerChallenge.Searches

  describe "return_show_url/1" do
    test "return {:ok, location} if response is ok" do
      process = "0000214-28.2011.8.02.0081"

      {:ok, _location} = Searches.return_show_url(process)
    end
  end

  describe "return_search_url/1" do
    test "return url by the given process" do
      process = "0000214-28.2011.8.02.0081"

      url = Searches.return_search_url(process)

      assert url =~ "numeroDigitoAnoUnificado=0000214-28.2011"
      assert url =~ "dadosConsulta.valorConsultaNuUnificado=0000214-28.2011.8.02.0081"
    end

    test "return {:error, :empty_process} if the process_n is not passed" do
      process = nil

      assert {:error, :empty_process} = Searches.return_search_url(process)
    end
  end

  describe "get_html_body/1" do
    test "return {:ok, body} by the given url" do
      process = "0000214-28.2011.8.02.0081"

      {:ok, location} = Searches.return_show_url(process)

      assert {:ok, _body} = Searches.get_html_body(location)
    end
  end

  describe "get_crawled_data/1" do
    test "return {:ok, result} if the data is scraped correctly" do
      process = "0000214-28.2011.8.02.0081"

      {:ok, location} = Searches.return_show_url(process)
      {:ok, body} = Searches.get_html_body(location)

      {:ok, _result} = Searches.get_crawled_data(body)
    end
  end
end
