defmodule Tennis.Repo.Migrations.CreateVenues do
  use Ecto.Migration

  def change do
    create table(:venues) do
      add(:name, :string, null: false)
      add(:address, :string, null: false)
      add(:description, :text)
      add(:number_of_courts, :integer, null: false)
      add(:has_lights, :boolean, default: true, null: false)

      timestamps()
    end

    create(unique_index(:venues, :address))
  end
end
