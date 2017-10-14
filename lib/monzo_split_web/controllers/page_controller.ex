defmodule MonzoSplitWeb.PageController do
  use MonzoSplitWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
