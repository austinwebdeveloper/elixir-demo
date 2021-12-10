defmodule TaskAppAuthWeb.AccountLive.New do
  use TaskAppAuthWeb, :live_view

  require Logger

  alias TaskAppAuth.Accounts

  alias TaskAppAuth.Accounts.Account

  def mount(_params, _session, socket) do
    changeset = Accounts.change_account(%Account{})
    display = 0
    # {:ok, assign(socket, changeset: changeset, display: 0)}

    {:ok,
     socket
     #  |> assign(socket.assigns)
     |> assign(:changeset, changeset)
     |> assign(:display, display)
     |> allow_upload(:image, accept: ~w(.jpg .jpeg .png), max_entries: 3)}
  end

  def handle_event("validate", %{"account" => user_params}, socket) do
    # IO.inspect(socket.assigns.changeset.changes)
    # Logger.info("before user params")
    # IO.inspect(socket.assigns.uploads)
    # Logger.info("after user params")

    # IO.inspect(socket.assigns.changeset.changes)

    changeset =
      %Account{}
      |> TaskAppAuth.Accounts.change_account(user_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("backward", _, socket) do
    # Logger.info("clicked backward")
    # IO.inspect(socket)

    count = socket.assigns.display - 1
    socket = assign(socket, :display, count)
    {:noreply, socket}
  end

  def handle_event("forward", _, socket) do
    # Logger.info("clicked forward")
    # IO.inspect(socket.assigns.changeset.changes)

    count = socket.assigns.display + 1

    socket = assign(socket, :display, count)

    {:noreply, socket}
  end

  def handle_event("save", %{"account" => user_params}, socket) do
    # Logger.info(" submitted from ")
    # IO.inspect(socket.assigns)

    file_path =
      consume_uploaded_entry(socket, :image, fn %{path: path}, _entry ->
        # dest = Path.join("priv/static/uploads", Path.basename(path))
        # File.cp!(path, dest)
        IO.inspect("inspect")
        # Routes.static_path(socket, "/uploads/#{Path.basename(dest)}")
      end)

    IO.inspect(file_path)

    case Accounts.create_account(Map.put(user_params, "image_upload", file_path)) do
      # case Accounts.create_account(user_params) do
      {:ok, account} ->
        {:noreply,
         socket
         |> put_flash(:info, "user created")}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect("error")
        # {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
