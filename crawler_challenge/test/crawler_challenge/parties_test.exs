defmodule CrawlerChallenge.PartiesTest do
  use CrawlerChallenge.DataCase

  alias CrawlerChallenge.Parties

  import CrawlerChallenge.Unpreloader

  describe "parties" do
    alias CrawlerChallenge.Parties.Partie

    @update_attrs %{
      name: "some updated name",
      partie: "some updated partie"
    }
    @invalid_attrs %{lawyer: nil, name: nil, partie: nil}

    test "list_parties/0 returns all parties" do
      partie = insert(:parties) |> forget(:process)
      assert Parties.list_parties() == [partie]
    end

    test "get_partie!/1 returns the partie with given id" do
      partie = insert(:parties) |> forget(:process)
      assert Parties.get_partie!(partie.id) == partie
    end

    test "create_partie/1 with valid data creates a partie" do
      valid_attrs = params_with_assocs(:parties)
      assert {:ok, %Partie{} = partie} = Parties.create_partie(valid_attrs)
      
      inserted_partie = Parties.get_partie!(partie.id)
      assert partie.name == inserted_partie.name
      assert partie.partie == inserted_partie.partie
    end

    test "create_partie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parties.create_partie(@invalid_attrs)
    end

    test "update_partie/2 with valid data updates the partie" do
      partie = insert(:parties) |> forget(:process)
      assert {:ok, %Partie{} = partie} = Parties.update_partie(partie, @update_attrs)
      assert partie.name == "some updated name"
      assert partie.partie == "some updated partie"
    end

    test "update_partie/2 with invalid data returns error changeset" do
      partie = insert(:parties) |> forget(:process)
      assert {:error, %Ecto.Changeset{}} = Parties.update_partie(partie, @invalid_attrs)
      assert partie == Parties.get_partie!(partie.id)
    end

    test "delete_partie/1 deletes the partie" do
      partie = insert(:parties) |> forget(:process)
      assert {:ok, %Partie{}} = Parties.delete_partie(partie)
      assert_raise Ecto.NoResultsError, fn -> Parties.get_partie!(partie.id) end
    end

    test "change_partie/1 returns a partie changeset" do
      partie = insert(:parties) |> forget(:process)
      assert %Ecto.Changeset{} = Parties.change_partie(partie)
    end
  end
end
