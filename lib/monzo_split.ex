defmodule MonzoSplit do
  @moduledoc """
  MonzoSplit keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def webhook_url do
    Applicatio.get_env(:monzo_split, :app_url) <> "/api/monzo/webhook"
  end

end
