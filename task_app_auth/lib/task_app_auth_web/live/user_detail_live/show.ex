defmodule TaskAppAuthWeb.UserDetailLive.Show do
  use TaskAppAuthWeb, :live_view

  alias TaskAppAuth.UserDetails

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user_detail, UserDetails.get_user_detail!(id))}
  end

  defp page_title(:show), do: "Show User detail"
  defp page_title(:edit), do: "Edit User detail"
end
