defmodule TennisWeb.MatchController do
  use TennisWeb, :controller

  alias Tennis.Tournaments
  alias Tennis.Tournaments.Match

  def index(conn, _params) do
    matches = Tournaments.list_matches()
    render(conn, "index.html", matches: matches)
  end

  def new(conn, _params) do
    changeset = Tournaments.change_match(%Match{})
    venues = Tournaments.list_venues_for_select()
    players = Tennis.Accounts.list_players_for_select()

    render(conn, "new.html", changeset: changeset, venues: venues, players: players)
  end

  def create(conn, %{"match" => match_params}) do
    case Tournaments.create_match(match_params) do
      {:ok, match} ->
        conn
        |> put_flash(:info, "Match created successfully.")
        |> redirect(to: match_path(conn, :show, match))

      {:error, %Ecto.Changeset{} = changeset} ->
        venues = Tournaments.list_venues_for_select()
        players = Tennis.Accounts.list_players_for_select()
        render(conn, "new.html", changeset: changeset, venues: venues, players: players)
    end
  end

  def show(conn, %{"id" => id}) do
    match = Tournaments.get_match!(id)
    render(conn, "show.html", match: match)
  end

  def edit(conn, %{"id" => id}) do
    match = Tournaments.get_match!(id)
    changeset = Tournaments.change_match(match)
    render(conn, "edit.html", match: match, changeset: changeset)
  end

  def update(conn, %{"id" => id, "match" => match_params}) do
    match = Tournaments.get_match!(id)

    case Tournaments.update_match(match, match_params) do
      {:ok, match} ->
        conn
        |> put_flash(:info, "Match updated successfully.")
        |> redirect(to: match_path(conn, :show, match))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", match: match, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    match = Tournaments.get_match!(id)
    {:ok, _match} = Tournaments.delete_match(match)

    conn
    |> put_flash(:info, "Match deleted successfully.")
    |> redirect(to: match_path(conn, :index))
  end
end
