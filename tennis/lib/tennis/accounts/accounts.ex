defmodule Tennis.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Tennis.Repo

  alias Tennis.Accounts.Player

  @doc """
  Returns the list of players.

  ## Examples

  iex> list_players()
  [%Player{}, ...]

  """
  def list_players do
    Repo.all(Player)
  end

  @doc """
  Returns a list of players to be used in a select helper.

  ## Examples
  iex> list_players_for_select()
  [[key: "PlayerName", value: "PlayerId"], ...]
  """
  def list_players_for_select() do
    Repo.all(Player)
    |> Enum.map(fn player -> [key: "#{player.name} <#{player.email}>", value: player.id] end)
  end

  @doc """
  Gets a single player.

  Raises `Ecto.NoResultsError` if the Player does not exist.

  ## Examples

  iex> get_player!(123)
  %Player{}

  iex> get_player!(456)
  ** (Ecto.NoResultsError)

  """
  def get(id), do: Repo.get(Player, id)

  def get_by(%{"email" => email}) do
    Repo.get_by(Player, email: email)
  end

  @doc """
  Creates a player.

  ## Examples

  iex> create_player(%{field: value})
  {:ok, %Player{}}

  iex> create_player(%{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player.

  ## Examples

  iex> update_player(player, %{field: new_value})
  {:ok, %Player{}}

  iex> update_player(player, %{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def update_player(%Player{} = player, attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Player.

  ## Examples

  iex> delete_player(player)
  {:ok, %Player{}}

  iex> delete_player(player)
  {:error, %Ecto.Changeset{}}

  """
  def delete_player(%Player{} = player) do
    Repo.delete(player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player changes.

  ## Examples

  iex> change_player(player)
  %Ecto.Changeset{source: %Player{}}

  """
  def change_player(%Player{} = player) do
    Player.changeset(player, %{})
  end

  def list_sessions(player_id) do
    with player when is_map(player) <- Repo.get(Player, player_id), do: player.sessions
  end

  def add_session(%Player{sessions: sessions} = player, session_id, timestamp) do
    change(player, sessions: put_in(sessions, [session_id], timestamp))
    |> Repo.update()
  end

  def delete_session(%Player{sessions: sessions} = player, session_id) do
    change(player, sessions: Map.delete(sessions, session_id))
    |> Repo.update()
  end

  def remove_old_sessions(session_age) do
    now = System.system_time(:second)

    Enum.map(
      list_players(),
      &(change(
          &1,
          sessions:
            :maps.filter(
              fn _, time ->
                time + session_age > now
              end,
              &1.sessions
            )
        )
        |> Repo.update())
    )
  end
end
