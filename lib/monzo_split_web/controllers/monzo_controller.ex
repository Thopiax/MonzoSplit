defmodule MonzoSplitWeb.Monzo.MonzoController do
  use MonzoSplitWeb, :controller
  alias MonzoSplitWeb.OAuthStrategy

  def start_oauth(conn, _params) do
    # Generate the authorization URL and redirect the user to the provider.
    redirect conn, external: OAuthStrategy.authorize_url!(:monzo)
  end

  def complete_oauth(conn, %{"code" => code}) do
    token = OAuthStrategy.get_token!(:monzo, code: code)

    conn
      |> assign(:monzo_token, token)
      |> render("index.html")
  end
end
