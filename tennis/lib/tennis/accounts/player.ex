defmodule Tennis.Accounts.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field(:name, :string)
    field(:email, :string)
    field(:wins, :integer)
    field(:losses, :integer)
    field(:role, :string, default: "player")
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:sessions, {:map, :integer}, default: %{})
    timestamps()

    has_many(:matches_player_one, Tennis.Tournaments.Match, foreign_key: :player_one_id)
    has_many(:matches_player_two, Tennis.Tournaments.Match, foreign_key: :player_two_id)
  end

  @valid_roles [
    "admin",
    "player"
  ]

  @doc false
  def changeset(player, params) do
    player
    |> cast(params, [:name, :email, :password, :wins, :losses, :role])
    |> validate_required([:name, :email])
    |> validate_inclusion(:role, @valid_roles, message: "Please select a valid role")
    |> validate_email()
  end

  def create_changeset(player, params) do
    player
    |> changeset(params)
    |> validate_password(:password)
    |> put_password_hash()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/@/, message: "should be an email address")
    |> update_change(:email, &String.trim/1)
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email)
  end

  def validate_password(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, password ->
      case NotQwerty123.PasswordStrength.strong_password?(password) do
        {:ok, _} -> []
        {:error, msg} -> [{field, options[:message] || msg}]
      end
    end)
  end

  # If you are using Argon2 or Pbkdf2, change Bcrypt to Argon2 or Pbkdf2
  def put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end

  def put_password_hash(changeset), do: changeset
end
