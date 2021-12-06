defmodule TaskAppAuthWeb.UserDetailLive.Index do
  use TaskAppAuthWeb, :live_view

  alias TaskAppAuth.UserDetails
  alias TaskAppAuth.UserDetails.UserDetail

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :user_detail_collection, list_user_detail())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User detail")
    |> assign(:user_detail, UserDetails.get_user_detail!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User detail")
    |> assign(:user_detail, %UserDetail{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing User detail")
    |> assign(:user_detail, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user_detail = UserDetails.get_user_detail!(id)
    {:ok, _} = UserDetails.delete_user_detail(user_detail)

    {:noreply, assign(socket, :user_detail_collection, list_user_detail())}
  end

  defp list_user_detail do
    UserDetails.list_user_detail()
  end

  def handle_event("next_dob", _, socket) do
    Logger.info('next')
    socket = assign(socket, :userdisplay, 1)
    Logger.info("done")

    {:noreply, socket}
  end

  def handle_event("test", _, socket) do
    Logger.info("clickkk eryuhjvghgcvhgvc")
    {:noreply, socket}
  end

  # def handle_event("increment", _, socket) do
  #   count = socket.assigns.count + 1
  #   socket = assign(socket, :count, count)
  #   {:noreply, socket}
  # end
end
