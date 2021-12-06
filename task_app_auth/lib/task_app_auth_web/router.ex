defmodule TaskAppAuthWeb.Router do
  use TaskAppAuthWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {TaskAppAuthWeb.LayoutView, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :protected do
    plug(Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
    )
  end

  scope "/", TaskAppAuthWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
    live("/user_detail", UserDetailLive.Index, :index)
    live("/user_detail/new", UserDetailLive.Index, :new)
    live("/user_detail/:id/edit", UserDetailLive.Index, :edit)

    live("/user_detail/:id", UserDetailLive.Show, :show)
    live("/user_detail/:id/show/edit", UserDetailLive.Show, :edit)
  end

  scope "/", TaskAppAuthWeb do
    pipe_through([:browser])
    resources("/tasks", TaskController)
    live("/details/new", DetailsLive.New, :new)
  end

  # Other scopes may use custom stacks.
  # scope "/api", TaskAppAuthWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through(:browser)
      pow_routes()
      live_dashboard("/dashboard", metrics: TaskAppAuthWeb.Telemetry)
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through(:browser)

      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
