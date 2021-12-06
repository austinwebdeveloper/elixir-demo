defmodule TaskAppAuthWeb.UserDetailLive.FormComponent do
  use TaskAppAuthWeb, :live_component

  alias TaskAppAuth.UserDetails

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    Logger.info('mount')
    {:ok, socket}
  end

  @impl true
  def update(%{user_detail: user_detail} = assigns, socket) do
    changeset = UserDetails.change_user_detail(user_detail)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:userdisplay, 0)
     |> assign(:testdisplay, 0)}
  end

  @impl true
  def handle_event("validate", %{"user_detail" => user_detail_params}, socket) do
    Logger.info('vcalidst #{socket.assigns.changeset}')

    changeset =
      socket.assigns.user_detail
      |> UserDetails.change_user_detail(user_detail_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"user_detail" => user_detail_params}, socket) do
    save_user_detail(socket, socket.assigns.action, user_detail_params)
  end

  def handle_event("next_dob", _, socket) do
    Logger.info("clickk testtt")
    {:noreply, socket}
    # save_user_detail(socket, socket.assigns.action, user_detail_params)
  end

  defp save_user_detail(socket, :edit, user_detail_params) do
    case UserDetails.update_user_detail(socket.assigns.user_detail, user_detail_params) do
      {:ok, _user_detail} ->
        {:noreply,
         socket
         |> put_flash(:info, "User detail updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_user_detail(socket, :new, user_detail_params) do
    case UserDetails.create_user_detail(user_detail_params) do
      {:ok, _user_detail} ->
        {:noreply,
         socket
         |> put_flash(:info, "User detail created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
