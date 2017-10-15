defmodule MonzoSplitWeb.PageController do
  use MonzoSplitWeb, :controller

  def index(conn, params) do
    render conn, "index.html"
  end
end
