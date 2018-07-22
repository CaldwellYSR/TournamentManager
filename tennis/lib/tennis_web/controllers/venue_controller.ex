defmodule TennisWeb.VenueController do
  use TennisWeb, :controller

  alias Tennis.Tournaments
  alias Tennis.Tournaments.Venue

  def index(conn, _params) do
    venues = Tournaments.list_venues()
    render(conn, "index.html", venues: venues)
  end

  def new(conn, _params) do
    changeset = Tournaments.change_venue(%Venue{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"venue" => venue_params}) do
    case Tournaments.create_venue(venue_params) do
      {:ok, venue} ->
        conn
        |> put_flash(:info, "Venue created successfully.")
        |> redirect(to: venue_path(conn, :show, venue))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    venue = Tournaments.get_venue!(id)
    render(conn, "show.html", venue: venue)
  end

  def edit(conn, %{"id" => id}) do
    venue = Tournaments.get_venue!(id)
    changeset = Tournaments.change_venue(venue)
    render(conn, "edit.html", venue: venue, changeset: changeset)
  end

  def update(conn, %{"id" => id, "venue" => venue_params}) do
    venue = Tournaments.get_venue!(id)

    case Tournaments.update_venue(venue, venue_params) do
      {:ok, venue} ->
        conn
        |> put_flash(:info, "Venue updated successfully.")
        |> redirect(to: venue_path(conn, :show, venue))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", venue: venue, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    venue = Tournaments.get_venue!(id)
    {:ok, _venue} = Tournaments.delete_venue(venue)

    conn
    |> put_flash(:info, "Venue deleted successfully.")
    |> redirect(to: venue_path(conn, :index))
  end
end
