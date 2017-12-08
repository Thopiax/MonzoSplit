defmodule MonzoSplitWeb.MonzoController do
  use MonzoSplitWeb, :controller
  alias MonzoSplitWeb.OAuthStrategy

  plug :fetch_session

  def start_oauth(conn, _params) do
    # Generate the authorization URL and redirect the user to the provider.
    redirect conn, external: OAuthStrategy.authorize_url!(:monzo)
  end

  def complete_oauth(conn, %{"code" => code}) do
    with client = %OAuth2.Client{token: token} <- OAuthStrategy.get_token!(:monzo, code: code),
         %{"accounts" => [account|_]}          <- OAuth2.Client.get!(client, "/accounts").body
    do
      setup_webhook(token, client, account)
      conn
      |> put_session(:monzo_token, token)
      |> redirect(to: "/")
    end
  end

  def setup_webhook(token, client, account) do
    body = %{url: MonzoSplit.webhook_url} |> oauth_body(account)
    case OAuthStrategy.post_form(client, "/webhooks", body) do
      {:ok, %HTTPoison.Response{body: body}} ->
        decoded_body = body |> Poison.decode!
        if webhook_id = decoded_body["webhook"]["id"] do
          Monzo.create_user(token, account, webhook_id)
        else
          raise HTTPoison.Error
        end
      _other ->
        raise HTTPoison.Error
    end
  end

  defp oauth_body(body, account) do
    body
    |> Map.put(:account_id, account["id"])
  end

end
