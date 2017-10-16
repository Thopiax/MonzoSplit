defmodule MonzoSplitWeb.AuthController do
  use MonzoSplitWeb, :controller
  require Phoenix.ConnTest
  alias MonzoSplitWeb.OAuthStrategy

  def start_monzo_oauth(conn, _params),     do: start_oauth(conn, :monzo)
  def start_splitwise_oauth(conn, _params), do: start_oauth(conn, :splitwise)

  defp start_oauth(conn, strategy) do
    # Generate the authorization URL and redirect the user to the provider.
    redirect conn, external: OAuthStrategy.authorize_url!(strategy)
  end

  def complete_monzo_oauth(conn, %{"code" => code}) do
    token = MonzoOAuthStrategy.get_token!(code: code)
    %{"accounts" => accounts} = OAuth2.Client.get!(token, "/accounts").body

    [account | _ ] = accounts

    response = OAuth2.Client.post!(token, "/webhooks", %{
      account_id: account["id"],
      url: "#{Application.get_env(:monzo_split, :app_url)}/api/monzo/transaction"
    })

    conn
      |> assign(:monzo_token, token)
      |> redirect(to: "/")
  end

  def complete_splitwise_oauth(conn, params), do: complete_oauth(conn, params, :splitwise)

  defp complete_oauth(conn, %{"code" => code}, strategy) do
    IO.inspect code
    token = OAuthStrategy.get_token!(strategy, code: code)

    conn
      |> assign(:splitwise_token, token)
      |> redirect(to: "/")
  end
end
