defmodule TaskAppAuthWeb.AccountLive.New do
  use TaskAppAuthWeb, :live_view

  require Logger

  alias TaskAppAuth.Accounts

  alias TaskAppAuth.Accounts.Account

  def mount(_params, _session, socket) do
    changeset = Accounts.change_account(%Account{})

    {:ok, assign(socket, changeset: changeset, display: 0)}
  end

  def handle_event("validate", %{"account" => user_params}, socket) do
    # IO.inspect(socket.assigns.changeset.changes)
    Logger.info("before user params")
    IO.inspect(user_params)
    Logger.info("after user params")

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
    Logger.info(" submitted from ")

    case Accounts.create_account(user_params) do
      {:ok, account} ->
        {:noreply,
         socket
         |> put_flash(:info, "user created")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
