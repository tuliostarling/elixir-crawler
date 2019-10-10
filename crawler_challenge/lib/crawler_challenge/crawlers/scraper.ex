defmodule CrawlerChallenge.Scraper do
  use Timex

  alias CrawlerChallenge.{Courts, Processes, Movements.Movement}

  def scrapy(body, court, process) do
    result = [
      scrapy_movements(body),
      scrapy_related(body) |> List.flatten(),
      scrapy_details(body)
    ]

    require IEx
    IEx.pry()

    # with %{id: court_id} <- Courts.get_court_by_name(court),
    #      Processes.create_process(%{"process_number" => process, "court_id" => court_id}) do
    #   {:ok, result}
    # end
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

      movement_date = Floki.find(element, "td:first-child") |> Floki.text() |> String.trim()

      movement =
        case movement do
          "" ->
            Floki.find(element, "td:nth-child(3)") |> Floki.text() |> String.trim()

          _ ->
            movement
        end

      %{
        "movement" => movement,
        "movement_date" => movement_date
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

      [first_position_name] =
        element
        |> Floki.find("td:last-child")
        |> List.first()
        |> Tuple.to_list()
        |> List.last()
        |> Enum.with_index()
        |> Enum.reduce([], fn {element, index}, acc ->
          if index == 0 do
            acc = [element |> String.replace(["\n", "\t"], "")]
          else
            acc
          end
        end)
        |> Enum.uniq()

      first_map = %{
        "partie" => first_position,
        "name" => first_position_name |> String.replace(["\n", "\t"], "")
      }

      case Floki.find(element, "td:nth-child(2) span") do
        [] ->
          first_map

        _ ->
          element
          |> Floki.find("td:last-child")
          |> List.first()
          |> Tuple.to_list()
          |> List.last()
          |> Floki.filter_out("br")
          |> Enum.with_index()
          |> Enum.reduce([], fn {element, index}, acc ->
            cond do
              index == 0 ->
                acc

              rem(index, 2) == 0 ->
                map_merged =
                  acc
                  |> List.last()
                  |> Map.merge(%{
                    "person_name_position" =>
                      element
                      |> Floki.text()
                      |> String.replace(["\n", "\t"], "")
                      |> String.trim()
                  })

                acc
                |> List.delete(List.last(acc))
                |> List.insert_at(index, map_merged)

              true ->
                List.insert_at(acc, index, %{
                  "position" => element |> Floki.text() |> String.replace(":", "")
                })
            end
          end)
          |> Enum.map(fn map ->
            Map.merge(first_map, map)
          end)
      end
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

          index <= 3 ->
            [detail, detail_value] =
              case Floki.find(element, "td label") do
                [] ->
                  element
                  |> Floki.find("td:nth-child(2) table tr td")
                  |> Floki.text()
                  |> String.trim()
                  |> String.split(" ")

                _ ->
                  detail =
                    element
                    |> Floki.find("td label")
                    |> Floki.text()
                    |> String.trim()

                  detail_value =
                    Floki.find(element, "td:nth-child(2) span") |> Floki.text() |> String.trim()

                  [detail, detail_value]
              end

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
            "#{detail |> String.replace(":", "")}" => detail_value
          })
      end
    end)
  end
end
