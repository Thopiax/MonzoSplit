defmodule MonzoSplitWeb.MonzoController do
  use MonzoSplitWeb, :controller
  require OAuth2

  def client do
    OAuth2.Client.new([
      strategy: OAuth2.Strategy.AuthCode, #default
      client_id: Application.get_env(:monzo_split, :monzo_client_id),
      client_secret: Application.get_env(:monzo_split, :monzo_client_secret),
      authorize_url: "https://auth.getmondo.co.uk",
      token_url: "https://api.monzo.com/oauth2/token",
      redirect_uri: "https://b8ccf680.ngrok.io/api/monzo_oauth/complete"
    ])
  end

  def start_monzo_oauth(conn, _params) do
    # Generate the authorization URL and redirect the user to the provider.
    url = OAuth2.Client.authorize_url!(client())
    redirect conn, external: url
  end

  def complete_monzo_oauth(conn, %{"code" => code}) do
    OAuth2.Client.get_token!(client(), code: code)
    conn
  end
end
