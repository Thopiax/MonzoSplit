defmodule MonzoSplitWeb.Router do
  use MonzoSplitWeb, :router

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

  scope "/", MonzoSplitWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", MonzoSplitWeb do
    pipe_through :api

    get "/oauth/monzo/start",    MonzoController, :start_oauth
    get "/oauth/monzo/complete", MonzoController, :complete_oauth

    get "/oauth/splitwise/start",    SplitwiseController, :start_oauth
    get "/oauth/splitwise/complete", SplitwiseController, :complete_oauth
  end
end
