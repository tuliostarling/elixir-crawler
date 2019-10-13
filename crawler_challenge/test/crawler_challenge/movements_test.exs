defmodule CrawlerChallenge.MovementsTest do
  use CrawlerChallenge.DataCase

  alias CrawlerChallenge.Movements

  describe "movements" do
    alias CrawlerChallenge.Movements.Movement

    @valid_attrs %{process_id: 1, movement: "some movement", movement_date: "14/10/2019"}
    @update_attrs %{process_id: 1, movement: "some updated movement", movement_date: "15/10/2019"}
    @invalid_attrs %{movement: nil, movement_date: nil}

    def movement_fixture(attrs \\ %{}) do
      {:ok, movement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Movements.create_movement()

      movement
    end

    test "list_movements/0 returns all movements" do
      movement = movement_fixture()
      assert Movements.list_movements() == [movement]
    end

    test "get_movement!/1 returns the movement with given id" do
      movement = movement_fixture()
      assert Movements.get_movement!(movement.id) == movement
    end

    test "create_movement/1 with valid data creates a movement" do
      assert {:ok, %Movement{} = movement} = Movements.create_movement(@valid_attrs)
      assert movement.movement == "some movement"
      assert movement.movement_date == ~N[2010-04-17 14:00:00]
    end

    test "create_movement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Movements.create_movement(@invalid_attrs)
    end

    test "update_movement/2 with valid data updates the movement" do
      movement = movement_fixture()
      assert {:ok, %Movement{} = movement} =
        Movements.update_movement(movement, @update_attrs)
      assert movement.movement == "some updated movement"
      assert movement.movement_date == ~N[2011-05-18 15:01:01]
    end

    test "update_movement/2 with invalid data returns error changeset" do
      movement = movement_fixture()
      assert {:error, %Ecto.Changeset{}} =
        Movements.update_movement(movement, @invalid_attrs)
      assert movement == Movements.get_movement!(movement.id)
    end

    test "delete_movement/1 deletes the movement" do
      movement = movement_fixture()
      assert {:ok, %Movement{}} = Movements.delete_movement(movement)
      assert_raise Ecto.NoResultsError, fn -> Movements.get_movement!(movement.id) end
    end

    test "change_movement/1 returns a movement changeset" do
      movement = movement_fixture()
      assert %Ecto.Changeset{} = Movements.change_movement(movement)
    end
  end
end
