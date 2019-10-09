defmodule CrawlerChallenge.Scraper do
  def scrapy(body) do
    movements = scrapy_movements(body)
    related = scrapy_related(body)
    details = scrapy_details(body)
  end

  defp scrapy_movements(body) do
    body
    |> Floki.find("table #tabelaUltimasMovimentacoes tr")
    |> scrapy_movements_data()
  end

  defp scrapy_movements_data(body) do
    body
    |> Enum.map(fn element ->
      movement = Floki.find(element, "td span") |> Floki.text() |> String.trim()
      date = Floki.find(element, "td:first-child") |> Floki.text() |> String.trim()

      %{
        "movement" => movement,
        "date" => date
      }
    end)
  end

  defp scrapy_related(body) do
    body
    |> Floki.find("#tablePartesPrincipais tr")
    |> scrapy_related_data()
  end

  defp scrapy_related_data(body) do
    body
    |> Enum.map(fn element ->
      first_position =
        element
        |> Floki.find("td:first-child span")
        |> Floki.text()
        |> String.trim()
        |> String.replace(":", "")

      [rest, lawyer_name] =
        Floki.find(element, "td:last-child") |> Floki.text() |> String.trim() |> String.split(":")

      [first_position_name, lawyer] = String.split(rest, "\t  \n")

      %{
        first_position => first_position_name |> String.replace(["\n", "\t"], ""),
        (lawyer |> String.replace(["\n", "\t"], "")) =>
          lawyer_name |> String.replace(["\n", "\t", " "], "")
      }
    end)
  end

  defp scrapy_details(body) do
    body
    |> Floki.find("table:not(#secaoFormConsulta).secaoFormBody:last-of-type tr")
    |> scrapy_details_data()
    |> Enum.uniq()
  end

  defp scrapy_details_data(body) do
    body
    |> Enum.with_index()
    |> Enum.reduce([], fn {element, index}, acc ->
      [detail, detail_value] =
        cond do
          index < 2 ->
            detail =
              element
              |> Floki.find("td label")
              |> Floki.text()
              |> String.trim()

            detail_value =
              element
              |> Floki.find("td table tr td span:first-child")
              |> Floki.text()
              |> String.trim()

            [detail, detail_value]

          index == 2 ->
            [detail, detail_value] =
              element
              |> Floki.find("td:nth-child(2) table tr td")
              |> Floki.text()
              |> String.trim()
              |> String.split(" ")

            [detail, detail_value]

          true ->
            detail =
              element
              |> Floki.find("td label")
              |> Floki.text()
              |> String.trim()

            detail_value =
              Floki.find(element, "td:nth-child(2) span") |> Floki.text() |> String.trim()

            [detail, detail_value]
        end

      cond do
        detail == "" ->
          acc

        detail_value == "" ->
          acc

        true ->
          List.insert_at(acc, index, %{
            "detail" => detail |> String.replace(":", ""),
            "detail_value" => detail_value
          })
      end
    end)
  end
end
