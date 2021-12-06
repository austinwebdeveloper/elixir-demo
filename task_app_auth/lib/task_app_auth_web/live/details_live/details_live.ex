defmodule TaskAppAuthWeb.DetailsLive.New do
  use TaskAppAuthWeb, :live_view

  alias TaskAppAuth.UserDetails
  alias TaskAppAuth.UserDetails.UserDetail
  require Logger

  @impl true
  def mount(_params, _session, socket) do
    changeset = UserDetails.change_user_detail(%UserDetail{})
    {:ok, assign(socket, changeset: changeset, userdisplay: false)}
  end
end
