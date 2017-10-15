defmodule MonzoSplitWeb.AuthController do
  use MonzoSplitWeb, :controller
  alias MonzoSplitWeb.OAuthStrategy

  def start_monzo_oauth(conn, _params),     do: start_oauth(conn, :monzo)
  def start_splitwise_oauth(conn, _params), do: start_oauth(conn, :splitwise)

  defp start_oauth(conn, strategy) do
    # Generate the authorization URL and redirect the user to the provider.
    redirect conn, external: OAuthStrategy.authorize_url!(strategy)
  end

  def complete_monzo_oauth(conn, params),     do: complete_oauth(conn, params, :monzo)
  def complete_splitwise_oauth(conn, params), do: complete_oauth(conn, params, :splitwise)

  defp complete_oauth(conn, %{"code" => code}, strategy) do
    token = OAuthStrategy.get_token!(strategy, code: code)

    conn
      |> assign(:monzo_token, token)
      |> render("index.html")
  end
end
