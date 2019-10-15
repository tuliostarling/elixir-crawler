defmodule CrawlerChallenge.ScraperTest do
  use CrawlerChallenge.DataCase

  alias CrawlerChallenge.{Parser, Scraper, Searches}

  describe "scrapy/1" do
    test "return data params from body parsed" do
      process = "0000214-28.2011.8.02.0081"

      {:ok, location} = Searches.return_show_url(process)

      {:ok, body} = Searches.get_html_body(location)

      result =
        body
        |> Parser.parse()
        |> Scraper.scrapy()

      expected_params = [
        list_movements: [
          %{
            "movement" =>
              "Em 26  de  junho  de  2019 é juntado a estes autos o aviso de recebimento (AR061676846TJ - Cumprido), referente  ao  ofício  n. 0000214-28.2011.8.02.0081-0001, emitido para Gerente do Banco do Brasil S.A - Agência 3557-2. Usuário:",
            "movement_date" => "26/06/2019"
          },
          %{
            "movement" => "AR DIGITAL - Ofício Genérico - Assinado pelo Servidor",
            "movement_date" => "05/06/2019"
          },
          %{
            "movement" => "Ato Ordinatório - Genérico",
            "movement_date" => "05/06/2019"
          },
          %{
            "movement" => "Classe Processual alterada",
            "movement_date" => "01/10/2018"
          },
          %{
            "movement" => "DESPACHO VISTO EM CORREIÇÃO",
            "movement_date" => "08/11/2017"
          }
        ],
        list_parties: [
          %{"name" => "JOSE CARLOS MARQUES DOS SANTOS   ", "partie" => "Demandante"},
          %{"name" => "ELETRÔNICA SANTOS   ", "partie" => "Demandado"}
        ],
        list_details: %{
          "area" => "Cível",
          "class" => "Cumprimento de sentençaCumprimento de sentença",
          "distribution_date" => "06/09/2011 às 10:20 - Sorteio",
          "other_numbers" => "001.2011.020.395-5",
          "process_number" => "0000214-28.2011.8.02.0081",
          "stock_price" => "500,00",
          "subject" => "Obrigação de Fazer / Não Fazer"
        }
      ]

      assert result = expected_params
    end
  end
end
