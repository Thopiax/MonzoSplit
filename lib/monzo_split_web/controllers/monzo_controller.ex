defmodule MonzoSplitWeb.MonzoController do
  use MonzoSplitWeb, :controller
  alias MonzoSplitWeb.MonzoOAuthStrate

  def start_monzo_oauth(conn, _params) do
    # Generate the authorization URL and redirect the user to the provider.
    redirect conn, external: MonzoOAuthStrategy.authorize_url!
  end

  def complete_monzo_oauth(conn, %{"code" => code}) do
    client = MonzoOAuthStrategy.get_token!(code: code)
    %{"accounts" => accounts} = OAuth2.Client.get!(client, "/accounts").body

    IO.inspect(accounts)

    [account | _ ] = accounts

    IO.inspect(account)
    IO.inspect(account["id"])

    response = OAuth2.Client.post!(client, "/webhooks", %{
      account_id: account["id"],
      url: "https://b8ccf680.ngrok.io/api/monzo/transaction"
    })

    IO.inspect(response)

    conn
      |> assign(:monzo_done, true)
      |> render("index.html")
  end
end
