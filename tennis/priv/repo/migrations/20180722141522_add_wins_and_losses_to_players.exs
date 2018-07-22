defmodule Tennis.Repo.Migrations.AddWinsAndLossesToPlayers do
  use Ecto.Migration

  def change do
    alter table(:players) do
      add(:wins, :integer, null: false, default: 0)
      add(:losses, :integer, null: false, default: 0)
    end
  end
end
