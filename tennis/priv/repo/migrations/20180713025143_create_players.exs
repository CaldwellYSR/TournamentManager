defmodule Tennis.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add(:name, :string, null: false)
      add(:email, :string, null: false)
      add(:password_hash, :string, null: false)
      add(:sessions, {:map, :integer}, default: "{}")

      timestamps()
    end

    create(unique_index(:players, :email))
  end
end
