defmodule MonzoOAuthStrategy do
  use OAuth2.Strategy

  def client do
    OAuth2.Client.new([
      strategy: __MODULE__,
      client_id: Application.get_env(:monzo_split, :monzo_client_id),
      client_secret: Application.get_env(:monzo_split, :monzo_client_secret),
      site: "https://api.monzo.com",
      authorize_url: "https://auth.getmondo.co.uk",
      token_url: "https://api.monzo.com/oauth2/token",
      redirect_uri: "https://b8ccf680.ngrok.io/api/monzo_oauth/complete"
    ])
  end

  def authorize_url! do
    OAuth2.Client.authorize_url!(client())
  end

  def get_token!(params \\ [], headers \\ [], opts \\ []) do
    OAuth2.Client.get_token!(client(), params, headers, opts)
  end

  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_param(:client_secret, client.client_secret)
    |> put_header("accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end
end
