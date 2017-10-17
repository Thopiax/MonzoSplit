defmodule MonzoSplitWeb.SplitwiseController do
  use MonzoSplitWeb, :controller
  alias MonzoSplitWeb.OAuthStrategy

  plug :fetch_session

  def start_oauth(conn, _params) do
    # Generate the authorization URL and redirect the user to the provider.
    redirect conn, external: OAuthStrategy.authorize_url!(:splitwise)
  end

  def complete_oauth(conn, %{"code" => code}) do
    %OAuth2.Client{token: token} = OAuthStrategy.get_token!(:splitwise, code: code)

    conn
      |> put_session(:splitwise_token, token)
      |> redirect(to: "/")
  end

end
