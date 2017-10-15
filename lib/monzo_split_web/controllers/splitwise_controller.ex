defmodule MonzoSplitWeb.Splitwise.SplitwiseController do
  use MonzoSplitWeb, :controller
  alias MonzoSplitWeb.OAuthStrategy

  def start_oauth(conn, _params) do
    # Generate the authorization URL and redirect the user to the provider.
    redirect conn, external: OAuthStrategy.authorize_url!(:splitwise)
  end

  def complete_oauth(conn, %{"code" => code}) do
    token = OAuthStrategy.get_token!(:splitwise, code: code)

    conn
      |> assign(:splitwise_token, token)
      |> render("index.html")
  end
end
