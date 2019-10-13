defmodule CrawlerChallenge.Scraper do
  def scrapy(body) do
    result = [
      list_movements: scrapy_movements(body),
      list_parties: body |> scrapy_parties() |> List.flatten(),
      list_details: body |> scrapy_details() |> List.delete_at(0) |> Enum.into(%{})
    ]

    {:ok, result}
  end

  # Scraping movements - beginning
  defp scrapy_movements(body) do
    body
    |> Floki.find("table #tabelaUltimasMovimentacoes tr")
    |> Enum.map(&scrapy_movements_data/1)
  end

  defp scrapy_movements_data(element) do
    %{
      "movement" =>
        element
        |> find_movement_data(Floki.find(element, "td span"))
        |> String.trim()
        |> String.replace(["\n", "\t"], ""),
      "movement_date" => element |> Floki.find("td:first-child") |> Floki.text() |> String.trim()
    }
  end

  defp find_movement_data(element, [{_, [{_, _}], []}]),
    do: element |> Floki.find("td:nth-child(3)") |> Floki.text()

  defp find_movement_data(_element, movement), do: Floki.text(movement)
  # Scraping movements - ending

  # Scraping parties - beginning
  defp scrapy_parties(body) do
    body
    |> Floki.find("#tablePartesPrincipais tr")
    |> Enum.map(&scrapy_parties_data/1)
  end

  defp scrapy_parties_data(element) do
    first_map = mount_first_map(element)

    case Floki.find(element, "td:nth-child(2) span") do
      [] ->
        first_map

      _ ->
        element
        |> mount_second_map(Floki.find(element, "td:nth-child(2) span"))
        |> Enum.map(fn map ->
          Map.merge(first_map, map)
        end)
    end
  end

  defp mount_first_map(element) do
    %{
      "partie" =>
        element
        |> Floki.find("td:first-child span")
        |> Floki.text()
        |> String.trim()
        |> String.replace(":", ""),
      "name" =>
        element
        |> scrapy_td_last_child()
        |> Enum.with_index()
        |> Enum.reduce([], &find_name_data/2)
    }
  end

  defp find_name_data({element, 0}, _acc), do: element |> String.replace(["\n", "\t"], "")

  defp find_name_data({_element, _index}, acc), do: acc

  defp mount_second_map(_element, []), do: [%{}]

  defp mount_second_map(element, _condition) do
    element
    |> scrapy_td_last_child()
    |> Enum.with_index()
    |> Enum.reduce([], &find_rest_of_data/2)
  end

  defp find_rest_of_data({_element, 0}, acc), do: acc

  defp find_rest_of_data({element, index}, acc) when rem(index, 2) == 0 do
    acc
    |> List.delete(List.last(acc))
    |> List.insert_at(index, merge_rest_data_map(element, acc))
  end

  defp find_rest_of_data({element, index}, acc) do
    List.insert_at(acc, index, %{
      "position" => element |> Floki.text() |> String.replace(":", "")
    })
  end

  defp merge_rest_data_map(element, acc) do
    acc
    |> List.last()
    |> Map.merge(%{
      "person_name_position" =>
        element
        |> Floki.text()
        |> String.replace(["\n", "\t"], "")
        |> String.trim()
    })
  end

  defp scrapy_td_last_child(element) do
    element
    |> Floki.find("td:last-child")
    |> List.first()
    |> Tuple.to_list()
    |> List.last()
    |> Floki.filter_out("br")
  end

  # Scraping parties - ending

  # Scraping details - beginning
  defp scrapy_details(body) do
    body
    |> Floki.find("table:not(#secaoFormConsulta).secaoFormBody:last-of-type tr")
    |> Enum.with_index()
    |> Enum.reduce(%{}, &find_details_data/2)
    |> Enum.uniq()
  end

  defp find_details_data({element, index}, acc) when index < 2 do
    detail =
      element
      |> Floki.find("td label")
      |> Floki.text()
      |> String.trim()
      |> convert_name_to_field_name_db()

    detail_value =
      element
      |> Floki.find("td table tr td span:first-child")
      |> Floki.text()
      |> String.trim()

    Map.merge(acc, %{detail => detail_value})
  end

  defp find_details_data({element, index}, acc) when index <= 3 do
    [detail, detail_value] =
      element
      |> get_rigth_value(Floki.find(element, "td label"))

    detail = convert_name_to_field_name_db(detail)

    Map.merge(acc, %{detail => detail_value})
  end

  defp find_details_data({element, _index}, acc) do
    detail =
      element
      |> Floki.find("td label")
      |> Floki.text()
      |> String.trim()
      |> convert_name_to_field_name_db()

    detail_value = element |> Floki.find("td:nth-child(2) span") |> Floki.text() |> String.trim()

    Map.merge(acc, %{detail => detail_value})
  end

  defp get_rigth_value(element, []) do
    element
    |> Floki.find("td:nth-child(2) table tr td")
    |> Floki.text()
    |> String.trim()
    |> String.split(" ")
  end

  defp get_rigth_value(element, _) do
    detail =
      element
      |> Floki.find("td label")
      |> Floki.text()
      |> String.trim()

    detail_value = element |> Floki.find("td:nth-child(2) span") |> Floki.text() |> String.trim()

    [detail, detail_value]
  end

  defp convert_name_to_field_name_db(""), do: ""
  defp convert_name_to_field_name_db("Assunto:"), do: "subject"
  defp convert_name_to_field_name_db("Classe:"), do: "class"
  defp convert_name_to_field_name_db("Custas:"), do: "costs"
  defp convert_name_to_field_name_db("Controle:"), do: "control"
  defp convert_name_to_field_name_db("Distribuição:"), do: "distribution_date"
  defp convert_name_to_field_name_db("Juiz:"), do: "judge"
  defp convert_name_to_field_name_db("Outros assuntos:"), do: "other_subject"
  defp convert_name_to_field_name_db("Outros números:"), do: "other_numbers"
  defp convert_name_to_field_name_db("Processo:"), do: "process_number"
  defp convert_name_to_field_name_db("Valor da ação:"), do: "stock_price"
  defp convert_name_to_field_name_db("Área:"), do: "area"
  # Scraping details - ending
end
