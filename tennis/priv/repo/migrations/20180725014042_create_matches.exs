defmodule Tennis.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add(:player_one_id, references(:players))
      add(:player_two_id, references(:players))
      add(:venue_id, references(:venues), null: false)
      add(:event_date, :date, null: false)

      timestamps()
    end

  end
end
