defmodule CrawlerChallenge.Searches do
  alias CrawlerChallenge.{Movements, Parser, Processes, Scraper}

  @domain "https://www2.tjal.jus.br"

  def return_show_url(url) do
    case HTTPoison.get(url, [],
           hackney: [cookie: "JSESSIONID=1381E2C506E4CB29CD78C1D0B940ADBA.cpopg1"]
         ) do
      {:ok, %{headers: headers}} -> 
        location = get_location(headers)
        {:ok, location}
      {:error, %{reason: reason}} -> {:error, reason}
    end
  end

  def get_location(nil), do: nil

  def get_location(headers) do
    [{"Location", location}] =
      Enum.filter(headers, fn
        {key, _} -> String.match?(key, ~r/\ALocation\z/i)
      end)

    @domain <> location
  end

  def get_html_body(url) do
    case HTTPoison.get(url, [],
           hackney: [cookie: "JSESSIONID=1381E2C506E4CB29CD78C1D0B940ADBA.cpopg1"]
         ) do
      {:ok, %{body: body}} ->
        {:ok, body}

      {:error, %{reason: reason}} ->
        {:error, reason}
    end
  end

  def get_crawled_data(body) do
    body
    |> Parser.parse()
    |> Scraper.scrapy()
    |> case do
      {:ok, result} -> {:ok, result}
      _ -> IO.puts("error")
    end
  end

  def mount_search_url(digit_number, process_n) do
    "https://www2.tjal.jus.br/cpopg/search.do?conversationId=&dadosConsulta.localPesquisa.cdLocal=81&" <>
      "cbPesquisa=NUMPROC&" <>
      "dadosConsulta.tipoNuProcesso=UNIFICADO&" <>
      "numeroDigitoAnoUnificado=" <>
      digit_number <>
      "&foroNumeroUnificado=0081&" <>
      "dadosConsulta.valorConsultaNuUnificado=" <>
      process_n <>
      "&dadosConsulta.valorConsulta=&" <>
      "uuidCaptcha=sajcaptcha_3e62afd94f694538b2e8545dfc40a899"
  end
end
