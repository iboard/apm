defmodule ApmPx.Router do
  @moduledoc """
  Routes requested url to controllers and functions
  """
  use ApmPx.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ApmPx do
    pipe_through :browser # Use the default browser stack

    get "/"       , PageController   , :index
    post "/login" , SessionController, :login
    post "/logout", SessionController, :logout

    get "/issues" , IssuesController,  :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ApmPx do
  #   pipe_through :api
  # end
end
