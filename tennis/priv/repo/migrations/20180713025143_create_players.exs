defmodule Tennis.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add(:name, :string, null: false)
      add(:email, :string, null: false)

      timestamps()
    end

    create(unique_index(:players, :email))
  end
end
