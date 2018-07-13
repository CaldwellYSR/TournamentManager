defmodule Tennis.Accounts.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field(:name, :string)
    field(:email, :string)
    # field(:password_hash, :string)
    # field(:password, :string, virtual: true)

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> validate_email
  end

  defp validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/@/, message: "should be an email address")
    |> update_change(:email, &String.trim/1)
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email)
  end
end
