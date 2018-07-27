defmodule Tennis.Tournaments.Match do
  use Ecto.Schema
  import Ecto.Changeset

  schema "matches" do
    field(:event_date, :date)
    timestamps()

    belongs_to(:venue, Tennis.Tournaments.Venue)
    belongs_to(:player_one, Tennis.Accounts.Player, foreign_key: :player_one_id)
    belongs_to(:player_two, Tennis.Accounts.Player, foreign_key: :player_two_id)
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:event_date, :venue_id, :player_one_id, :player_two_id])
    |> validate_required([:event_date, :venue_id, :player_one_id, :player_two_id])
    |> validate_unique_players()
  end

  def validate_unique_players(changeset) do
    changeset
    |> validate_change(:player_one_id, fn _field, player_one_id ->
      player_two_id = get_field(changeset, :player_two_id)

      if player_one_id == player_two_id do
        [player_one_id: "Fool... you just played yourself"]
      else
        []
      end
    end)
  end
end
