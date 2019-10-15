defmodule CrawlerChallenge.ParserTest do
  use CrawlerChallenge.DataCase

  alias CrawlerChallenge.Parser

  @html """
    <html>
      <head>
        <title>Test</title>
      </head>
      <body>
        <div class="content">
          <a href="http://google.com" class="js-google js-cool">Google</a>
          <a href="http://elixir-lang.org" class="js-elixir js-cool">Elixir lang</a>
          <a href="http://java.com" class="js-java">Java</a>
        </div>
      </body>
    </html>
  """

  test "parse simple HTML" do
    parsed = Parser.parse(@html)

    assert parsed == {
             "html",
             [],
             [
               {"head", [], [{"title", [], ["Test"]}]},
               {"body", [],
                [
                  {"div", [{"class", "content"}],
                   [
                     {
                       "a",
                       [
                         {"href", "http://google.com"},
                         {"class", "js-google js-cool"}
                       ],
                       ["Google"]
                     },
                     {
                       "a",
                       [
                         {"href", "http://elixir-lang.org"},
                         {"class", "js-elixir js-cool"}
                       ],
                       ["Elixir lang"]
                     },
                     {
                       "a",
                       [
                         {"href", "http://java.com"},
                         {"class", "js-java"}
                       ],
                       ["Java"]
                     }
                   ]}
                ]}
             ]
           }
  end
end
