defmodule TennisWeb.Router do
  use TennisWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(Phauxth.Authenticate)
    plug(Phauxth.Remember)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", TennisWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/players", PlayerController)
    resources("/sessions", SessionController, only: [:new, :create, :delete])
    resources("/venues", VenueController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", TennisWeb do
  #   pipe_through :api
  # end
end
