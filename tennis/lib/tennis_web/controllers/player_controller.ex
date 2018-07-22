defmodule TennisWeb.PlayerController do
  use TennisWeb, :controller

  import TennisWeb.Authorize
  alias Phauxth.Log
  alias Tennis.Accounts
  alias Tennis.Accounts.Player

  plug(:role_check, [roles: ["admin"]] when action in [:index, :delete])
  plug(:id_or_role, [roles: ["admin"]] when action in [:show, :update, :edit])

  def index(conn, _params) do
    players = Accounts.list_players()
    render(conn, "index.html", players: players)
  end

  def new(conn, _params) do
    changeset = Accounts.change_player(%Player{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"player" => player_params}) do
    case Accounts.create_player(player_params) do
      {:ok, player} ->
        conn
        |> put_flash(:info, "Player created successfully.")
        |> redirect(to: player_path(conn, :show, player))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    player = Accounts.get(id)
    render(conn, "show.html", player: player)
  end

  def edit(conn, %{"id" => id}) do
    player = Accounts.get(id)
    changeset = Accounts.change_player(player)
    render(conn, "edit.html", player: player, changeset: changeset)
  end

  def update(conn, %{"id" => id, "player" => player_params}) do
    player = Accounts.get(id)

    case Accounts.update_player(player, player_params) do
      {:ok, player} ->
        conn
        |> put_flash(:info, "Player updated successfully.")
        |> redirect(to: player_path(conn, :show, player))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", player: player, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    player = Accounts.get(id)
    {:ok, _player} = Accounts.delete_player(player)

    conn
    |> put_flash(:info, "Player deleted successfully.")
    |> redirect(to: player_path(conn, :index))
  end
end
