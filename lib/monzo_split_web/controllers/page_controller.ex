defmodule MonzoSplitWeb.PageController do
  use MonzoSplitWeb, :controller

  def index(conn, params) do
    IO.inspect conn
    render conn, "index.html"
  end
end
