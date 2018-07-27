defmodule Tennis.Tournaments.Venue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "venues" do
    field(:name, :string)
    field(:address, :string)
    field(:description, :string)
    field(:number_of_courts, :integer)
    field(:has_lights, :boolean)
    timestamps()

    has_many(:matches, Tennis.Tournaments.Match)
  end

  @doc false
  def changeset(venue, params) do
    venue
    |> cast(params, [:name, :address, :description, :number_of_courts, :has_lights])
    |> validate_required([:name, :address, :number_of_courts])
  end
end
