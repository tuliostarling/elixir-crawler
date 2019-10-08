defmodule CrawlerChallenge.Search do
  def return_location(url) do
    case HTTPoison.get(url, [], hackney: [cookie: "JSESSIONID=anyjsession.cpopg1"]) do
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
    case HTTPoison.get(url, [], hackney: [cookie: "JSESSIONID=anyjsession.cpopg1"]) do
      {:ok, response} ->
          require IEx
          IEx.pry()
          {:ok, response}
      {:error, %{reason: reason}} ->
        {:error, reason}
    end
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