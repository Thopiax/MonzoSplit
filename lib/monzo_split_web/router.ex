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

    scope "/monzo", Monzo do
      get "/oauth/start",    MonzoController, :start_oauth
      get "/oauth/complete", MonzoController, :complete_oauth
    end

    scope "/spliwise", Splitwise do
      get "/oauth/start",    SplitwiseController, :start_oauth
      get "/oauth/complete", SplitwiseController, :complete_oauth
    end
  end
end
