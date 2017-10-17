defmodule MonzoSplitWeb.MonzoController do
  use MonzoSplitWeb, :controller
  alias MonzoSplitWeb.OAuthStrategy

  plug :fetch_session

  def start_oauth(conn, _params) do
    # Generate the authorization URL and redirect the user to the provider.
    redirect conn, external: OAuthStrategy.authorize_url!(:monzo)
  end

  def complete_oauth(conn, %{"code" => code}) do
    with token                        =  OAuthStrategy.get_token!(:monzo, code: code),
         %{"accounts" => [account|_]} <- OAuth2.Client.get!(token, "/accounts").body
    do
      response = setup_webhook(token, account)
      conn
        |> put_session(:monzo_token, token)
        |> redirect(to: "/")
    end
  end

  def setup_webhook(token, account) do
    body = JSON.encode!(%{
      account_id: account["id"],
      url: "#{Application.get_env(:monzo_split, :app_url)}/api/monzo/webhook"
    })
    OAuth2.Client.post(token, "/webhooks", body)
  end
end
