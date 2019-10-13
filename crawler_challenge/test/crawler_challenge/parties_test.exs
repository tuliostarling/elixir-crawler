defmodule CrawlerChallenge.PartiesTest do
  use CrawlerChallenge.DataCase

  alias CrawlerChallenge.Parties

  describe "parties" do
    alias CrawlerChallenge.Parties.Partie

    @valid_attrs %{lawyer: "some lawyer", name: "some name", partie: "some partie"}
    @update_attrs %{
      lawyer: "some updated lawyer",
      name: "some updated name",
      partie: "some updated partie"
    }
    @invalid_attrs %{lawyer: nil, name: nil, partie: nil}

    def partie_fixture(attrs \\ %{}) do
      {:ok, partie} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Parties.create_partie()

      partie
    end

    test "list_parties/0 returns all parties" do
      partie = partie_fixture()
      assert Parties.list_parties() == [partie]
    end

    test "get_partie!/1 returns the partie with given id" do
      partie = partie_fixture()
      assert Parties.get_partie!(partie.id) == partie
    end

    test "create_partie/1 with valid data creates a partie" do
      assert {:ok, %Partie{} = partie} = Parties.create_partie(@valid_attrs)
      assert partie.lawyer == "some lawyer"
      assert partie.name == "some name"
      assert partie.partie == "some partie"
    end

    test "create_partie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parties.create_partie(@invalid_attrs)
    end

    test "update_partie/2 with valid data updates the partie" do
      partie = partie_fixture()
      assert {:ok, %Partie{} = partie} = Parties.update_partie(partie, @update_attrs)
      assert partie.lawyer == "some updated lawyer"
      assert partie.name == "some updated name"
      assert partie.partie == "some updated partie"
    end

    test "update_partie/2 with invalid data returns error changeset" do
      partie = partie_fixture()
      assert {:error, %Ecto.Changeset{}} = Parties.update_partie(partie, @invalid_attrs)
      assert partie == Parties.get_partie!(partie.id)
    end

    test "delete_partie/1 deletes the partie" do
      partie = partie_fixture()
      assert {:ok, %Partie{}} = Parties.delete_partie(partie)
      assert_raise Ecto.NoResultsError, fn -> Parties.get_partie!(partie.id) end
    end

    test "change_partie/1 returns a partie changeset" do
      partie = partie_fixture()
      assert %Ecto.Changeset{} = Parties.change_partie(partie)
    end
  end
end
