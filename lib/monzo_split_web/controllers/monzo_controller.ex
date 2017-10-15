defmodule MonzoSplitWeb.MonzoController do
  use MonzoSplitWeb, :controller
  alias MonzoSplitWeb.MonzoOAuthStrate

  def start_monzo_oauth(conn, _params) do
    # Generate the authorization URL and redirect the user to the provider.
    redirect conn, external: MonzoOAuthStrategy.authorize_url!
  end

  def complete_monzo_oauth(conn, %{"code" => code}) do
    client = MonzoOAuthStrategy.get_token!(code: code)
    
    conn
      |> assign(:monzo_done, true)
      |> render("index.html")
  end
end
