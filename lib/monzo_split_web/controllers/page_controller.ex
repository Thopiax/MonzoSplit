defmodule MonzoSplitWeb.PageController do
  use MonzoSplitWeb, :controller
  use Drab.Controller

  def index(conn, params) do
    render conn, "index.html"
  end
end
