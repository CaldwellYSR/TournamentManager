defmodule Tennis.TournamentsTest do
  use Tennis.DataCase

  alias Tennis.Tournaments

  describe "venues" do
    alias Tennis.Tournaments.Venue

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def venue_fixture(attrs \\ %{}) do
      {:ok, venue} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tournaments.create_venue()

      venue
    end

    test "list_venues/0 returns all venues" do
      venue = venue_fixture()
      assert Tournaments.list_venues() == [venue]
    end

    test "get_venue!/1 returns the venue with given id" do
      venue = venue_fixture()
      assert Tournaments.get_venue!(venue.id) == venue
    end

    test "create_venue/1 with valid data creates a venue" do
      assert {:ok, %Venue{} = venue} = Tournaments.create_venue(@valid_attrs)
    end

    test "create_venue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tournaments.create_venue(@invalid_attrs)
    end

    test "update_venue/2 with valid data updates the venue" do
      venue = venue_fixture()
      assert {:ok, venue} = Tournaments.update_venue(venue, @update_attrs)
      assert %Venue{} = venue
    end

    test "update_venue/2 with invalid data returns error changeset" do
      venue = venue_fixture()
      assert {:error, %Ecto.Changeset{}} = Tournaments.update_venue(venue, @invalid_attrs)
      assert venue == Tournaments.get_venue!(venue.id)
    end

    test "delete_venue/1 deletes the venue" do
      venue = venue_fixture()
      assert {:ok, %Venue{}} = Tournaments.delete_venue(venue)
      assert_raise Ecto.NoResultsError, fn -> Tournaments.get_venue!(venue.id) end
    end

    test "change_venue/1 returns a venue changeset" do
      venue = venue_fixture()
      assert %Ecto.Changeset{} = Tournaments.change_venue(venue)
    end
  end

  describe "matches" do
    alias Tennis.Tournaments.Match

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def match_fixture(attrs \\ %{}) do
      {:ok, match} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tournaments.create_match()

      match
    end

    test "list_matches/0 returns all matches" do
      match = match_fixture()
      assert Tournaments.list_matches() == [match]
    end

    test "get_match!/1 returns the match with given id" do
      match = match_fixture()
      assert Tournaments.get_match!(match.id) == match
    end

    test "create_match/1 with valid data creates a match" do
      assert {:ok, %Match{} = match} = Tournaments.create_match(@valid_attrs)
    end

    test "create_match/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tournaments.create_match(@invalid_attrs)
    end

    test "update_match/2 with valid data updates the match" do
      match = match_fixture()
      assert {:ok, match} = Tournaments.update_match(match, @update_attrs)
      assert %Match{} = match
    end

    test "update_match/2 with invalid data returns error changeset" do
      match = match_fixture()
      assert {:error, %Ecto.Changeset{}} = Tournaments.update_match(match, @invalid_attrs)
      assert match == Tournaments.get_match!(match.id)
    end

    test "delete_match/1 deletes the match" do
      match = match_fixture()
      assert {:ok, %Match{}} = Tournaments.delete_match(match)
      assert_raise Ecto.NoResultsError, fn -> Tournaments.get_match!(match.id) end
    end

    test "change_match/1 returns a match changeset" do
      match = match_fixture()
      assert %Ecto.Changeset{} = Tournaments.change_match(match)
    end
  end
end
