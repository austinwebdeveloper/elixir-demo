defmodule TaskAppAuthWeb.AccountLive.New do
  use TaskAppAuthWeb, :live_view

  require Logger

  alias TaskAppAuth.Accounts

  alias TaskAppAuth.Accounts.Account

  def mount(_params, _session, socket) do
    changeset = Accounts.change_account(%Account{})
    display = 0
    success = true
    disable = true
    # {:ok, assign(socket, changeset: changeset, display: 0)}
    {:ok,
     socket
     #  |> assign(socket.assigns)
     |> assign(:changeset, changeset)
     |> assign(:display, display)
     |> assign(:success, success)
     |> assign(:disable, disable)
     |> allow_upload(:image, accept: ~w(.jpg .jpeg .png .pdf), max_entries: 1)}
  end

  def handle_event("validate", %{"account" => user_params}, socket) do
    display = socket.assigns.display

    btn =
      case display do
        0 ->
          if user_params["first_name"] != "" and user_params["last_name"] != "" and
               user_params["email"] != "" do
            false
          end

        1 ->
          if user_params["dob"] != "" and user_params["phone_number"] != "" do
            false
          end

        2 ->
          if user_params["street_address"] != "" and user_params["zip_code"] != "" and
               user_params["city"] != "" and user_params["state"] != "" do
            false
          end

        3 ->
          if user_params["password"] != "" and user_params["ssn"] != "" do
            false
          end

        _ ->
          false
      end

    changeset =
      %Account{}
      |> TaskAppAuth.Accounts.change_account(user_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset, disable: "#{btn}")}
  end

  def handle_event("backward", _, socket) do
    count = socket.assigns.display - 1
    # socket = assign(socket, display: count, disable: "false")
    socket = assign(socket, :display, count)
    {:noreply, socket}
  end

  def handle_event("forward", _, socket) do
    # Logger.info("clicked forward")
    count = socket.assigns.display + 1
    # socket = assign(socket, display: count, disable: "true")
    socket = assign(socket, :display, count)
    {:noreply, socket}
  end

  def handle_event("save", %{"account" => user_params}, socket) do
    file_path =
      consume_uploaded_entries(socket, :image, fn %{path: path}, _entry ->
        dest = Path.join("priv/static/uploads", Path.basename(path))
        File.cp!(path, dest)
        Routes.static_path(socket, "/uploads/#{Path.basename(dest)}")
      end)

    [head | tail] = file_path

    case Accounts.create_account(Map.put(user_params, "image_upload", head)) do
      {:ok, account} ->
        socket = assign(socket, :success, false)

        {:noreply,
         socket
         |> put_flash(:info, "Account created")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
