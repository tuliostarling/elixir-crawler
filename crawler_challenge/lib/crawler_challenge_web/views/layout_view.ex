defmodule CrawlerChallengeWeb.LayoutView do
  use CrawlerChallengeWeb, :view

  alias CrawlerChallenge.Courts

  def show_courts(), do: Courts.list_courts
end
