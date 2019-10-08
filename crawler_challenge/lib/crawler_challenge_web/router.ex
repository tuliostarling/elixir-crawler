defmodule CrawlerChallengeWeb.Router do
  use CrawlerChallengeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CrawlerChallengeWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/search", SearchController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", CrawlerChallengeWeb do
  #   pipe_through :api
  # end
end
