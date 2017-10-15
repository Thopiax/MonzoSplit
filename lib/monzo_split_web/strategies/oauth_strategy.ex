defmodule MonzoSplitWeb.OAuthStrategy do
  use OAuth2.Strategy

  def client(strategy) when strategy in [:monzo, :splitwise] do
    oauth = Application.get_env(:monzo_split, strategy)

    OAuth2.Client.new([
      strategy:      __MODULE__,
      client_id:     oauth.client_id,
      client_secret: oauth.client_secret,
      site:          oauth.website,
      authorize_url: oauth.authorize_url,
      token_url:     oauth.token_url,
      redirect_uri:  oauth.redirect_uri
    ])
  end

  def authorize_url!(strategy) do
    OAuth2.Client.authorize_url!(client(strategy))
  end

  def get_token!(strategy, params \\ [], headers \\ [], opts \\ []) do
    OAuth2.Client.get_token!(client(strategy), params, headers, opts)
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
