defmodule CrawlerChallenge.CourtsTest do
  use CrawlerChallenge.DataCase

  alias CrawlerChallenge.Courts

  describe "courts" do
    alias CrawlerChallenge.Courts.Court

    @valid_attrs %{name: "some name", initials: "some initials"}
    @update_attrs %{name: "some updated name", initials: "some initials"}
    @invalid_attrs %{name: nil}

    def court_fixture(attrs \\ %{}) do
      {:ok, court} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Courts.create_court()

      court
    end

    test "list_courts/0 returns all courts" do
      court = court_fixture()
      assert Courts.list_courts() == [court]
    end

    test "get_court!/1 returns the court with given id" do
      court = court_fixture()
      assert Courts.get_court!(court.id) == court
    end

    test "get_court_by_name/1 returns the court with given name" do
      court = court_fixture()
      assert Courts.get_court_by_name(court.name) == court
    end

    test "create_court/1 with valid data creates a court" do
      assert {:ok, %Court{} = court} = Courts.create_court(@valid_attrs)
      assert court.name == "some name"
    end

    test "create_court/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Courts.create_court(@invalid_attrs)
    end

    test "update_court/2 with valid data updates the court" do
      court = court_fixture()
      assert {:ok, %Court{} = court} = Courts.update_court(court, @update_attrs)
      assert court.name == "some updated name"
    end

    test "update_court/2 with invalid data returns error changeset" do
      court = court_fixture()
      assert {:error, %Ecto.Changeset{}} = Courts.update_court(court, @invalid_attrs)
      assert court == Courts.get_court!(court.id)
    end

    test "delete_court/1 deletes the court" do
      court = court_fixture()
      assert {:ok, %Court{}} = Courts.delete_court(court)
      assert_raise Ecto.NoResultsError, fn -> Courts.get_court!(court.id) end
    end

    test "change_court/1 returns a court changeset" do
      court = court_fixture()
      assert %Ecto.Changeset{} = Courts.change_court(court)
    end
  end
end
