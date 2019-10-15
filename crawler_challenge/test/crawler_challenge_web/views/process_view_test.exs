defmodule CrawlerChallengeWeb.ProcessViewTest do
  use CrawlerChallengeWeb.ConnCase

  alias CrawlerChallenge.Courts
  alias CrawlerChallengeWeb.ProcessView

  test "show_courts/0" do
    _courts = ProcessView.show_courts()
    assert courts = Courts.list_courts()
  end
end
