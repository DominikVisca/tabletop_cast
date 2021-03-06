defmodule TabletopCastWeb.Router do
  use TabletopCastWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TabletopCastWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TabletopCastWeb do
    pipe_through :browser

    live "/", PageLive, :index

    resources "/rooms", RoomController do
      resources "/audio", AudioController, except: [:new, :create, :delete]
    end

    scope "/room" do
      live "/new", Room.NewLive, :new
      live "/:slug", Room.ShowLive, :show
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", TabletopCastWeb do
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
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TabletopCastWeb.Telemetry
    end
  end
end
