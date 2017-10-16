defmodule MonzoSplitWeb.PageController do
  use MonzoSplitWeb, :controller

  def index(conn, params) do
    IO.inspect conn
    with splitwise_token <- conn |> fetch_session |> get_session(:splitwise_token),
         monzo_token     <- conn |> fetch_session |> get_session(:monzo_token)
    do
      IO.inspect splitwise_token
      IO.inspect monzo_token
      render conn, "index.html", tokens: %{splitwise_token: splitwise_token, monzo_token: monzo_token}
    end
  end
end
