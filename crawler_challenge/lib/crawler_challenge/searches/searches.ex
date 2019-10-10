defmodule CrawlerChallenge.Searches do
  alias CrawlerChallenge.{Movements, Parser, Processes, Scraper}

  def return_show_url(url) do
    case HTTPoison.get(url, [], hackney: [cookie: "JSESSIONID=1381E2C506E4CB29CD78C1D0B940ADBA.cpopg1"]) do
      {:ok, %{headers: headers}} ->
        url =
          headers
          |> Enum.filter(fn
            {key, _} -> String.match?(key, ~r/\ALocation\z/i)
          end)
          |> mount_show_url()

          {:ok, url}
      {:error, %{reason: reason}} ->
        {:error, reason}
    end
  end

  def get_html_body(url) do
    case HTTPoison.get(url, [], hackney: [cookie: "JSESSIONID=1381E2C506E4CB29CD78C1D0B940ADBA.cpopg1"]) do
      {:ok, %{body: body}} ->
        {:ok, body}
      {:error, %{reason: reason}} ->
        {:error, reason}
    end
  end

  def get_value_from_scraper_and_insert(body, court, process_n) do
    body
    |> Parser.parse()
    |> Scraper.scrapy(court, process_n)
    |> case do
      {:ok, result} ->
        %{id: process_id} = Processes.get_process_by_number(process_n)
        insert_db(result, process_id)
      _ -> IO.puts("error")
    end
  end

  def insert_db([], _id), do: {:ok, []}

  def insert_db([head | tail], id) do
    Enum.map(head, fn params ->
      params
      |> Map.merge(%{"process_id" => id})
      |> Movements.create_movement()
    end)

    insert_db(tail, id)
  end

  def mount_search_url(digit_number, process_n) do
    "https://www2.tjal.jus.br/cpopg/search.do?conversationId=&dadosConsulta.localPesquisa.cdLocal=81&cbPesquisa=NUMPROC&dadosConsulta.tipoNuProcesso=UNIFICADO&numeroDigitoAnoUnificado=" <>
      digit_number <>
      "&foroNumeroUnificado=0081&dadosConsulta.valorConsultaNuUnificado=" <>
      process_n <>
      "&dadosConsulta.valorConsulta=&uuidCaptcha=sajcaptcha_3e62afd94f694538b2e8545dfc40a899"
  end

  defp mount_show_url([{"Location", location}]) do
    "https://www2.tjal.jus.br" <> location
  end
end
