defmodule MonzoSplitWeb.PageController do
  use MonzoSplitWeb, :controller
  use Drab.Controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
