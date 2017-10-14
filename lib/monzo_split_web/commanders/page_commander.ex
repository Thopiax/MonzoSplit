defmodule MonzoSplitWeb.PageCommander do
  use Drab.Commander
  # Place your event handlers here
  #
  # def button_clicked(socket, sender) do
  #   set_prop socket, "#output_div", innerHTML: "Clicked the button!"
  # end
  #
  # Place you callbacks here
  #
  # onload :page_loaded
  #
  # def page_loaded(socket) do
  #   set_prop socket, "div.jumbotron h2", innerText: "This page has been drabbed"
  # end

  def handle_splitwise_click(socket, _sender) do
  end
  def handle_monzo_click(socket, _sender) do
  end
end
