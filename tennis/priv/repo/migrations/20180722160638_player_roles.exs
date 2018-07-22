defmodule Tennis.Repo.Migrations.PlayerRoles do
  use Ecto.Migration

  def change do
    alter table(:players) do
      add(:role, :string, null: false, default: "player")
    end
  end
end
