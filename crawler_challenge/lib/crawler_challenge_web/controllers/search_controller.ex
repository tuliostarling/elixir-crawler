defmodule CrawlerChallengeWeb.SearchController do
  use CrawlerChallengeWeb, :controller

  alias CrawlerChallenge.Searches

  def index(conn, %{"court" => court, "process_n" => process_n}) do
    search_url =
      process_n
      |> String.slice(0, 15)
      |> Searches.mount_search_url(process_n)

    with {:ok, show_url} <- Searches.return_show_url(search_url),
         {:ok, body} <- Searches.get_html_body(show_url),
        #  {:ok, crawled_data} <- Scraper.thimgs(body),
        #  {:ok, process} <- Create.process(process)
        #  {:ok, list_movements} <- Create.listOfmovements(process.id, crawled_data.list_movements),
        #  {:ok, process-parts} <- Create.ProcessParts(process.id, crawed_data.process_parts)
         {:ok, []} <- Searches.get_value_from_scraper_and_insert(body, court, process_n) do
      conn
    else
      {:error, reason} ->
        {:error, reason}
    end
  end
end


# def insert_all_shit(all_shit) do
#     Multi.new()
#     |> Multi.insert(process,proces-changeset)
#     |> Multi.run({proces}fn x ->

#       for each list_movements do
#         insert(list, process_id)
#       end
#     end)
#     |> Multi.run(fn x ->
#       for each process_parts do
#       insert(process)
#       end
#     end)
#     |> multi.transctin-start
#     |> repo.insert
# end


# %{
#   list_movements: [1,2,3,]
#   process_parts: [1,2,3]
# }