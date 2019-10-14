defmodule CrawlerChallenge.MovementsTest do
  use CrawlerChallenge.DataCase

  alias CrawlerChallenge.Movements

  import CrawlerChallenge.Unpreloader

  describe "movements" do
    alias CrawlerChallenge.Movements.Movement

    @update_attrs %{movement: "some updated movement", movement_date: "15/10/2019"}
    @invalid_attrs %{movement: nil, movement_date: nil}

    test "list_movements/0 returns all movements" do
      movement = insert(:movements) |> forget(:process)
      assert Movements.list_movements() == [movement]
    end

    test "get_movement!/1 returns the movement with given id" do
      movement = insert(:movements) |> forget(:process)
      assert Movements.get_movement!(movement.id) == movement
    end

    test "create_movement/1 with valid data creates a movement" do
      valid_attrs = params_with_assocs(:movements)
      assert {:ok, %Movement{} = movement} = Movements.create_movement(valid_attrs)
      assert movement.movement_date == "14/10/2019"
    end

    test "create_movement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Movements.create_movement(@invalid_attrs)
    end

    test "update_movement/2 with valid data updates the movement" do
      movement = insert(:movements) |> forget(:process)
      assert {:ok, %Movement{} = movement} = Movements.update_movement(movement, @update_attrs)
      assert movement.movement == "some updated movement"
      assert movement.movement_date == "15/10/2019"
    end

    test "update_movement/2 with invalid data returns error changeset" do
      movement = insert(:movements) |> forget(:process)
      assert {:error, %Ecto.Changeset{}} = Movements.update_movement(movement, @invalid_attrs)
      assert movement == Movements.get_movement!(movement.id)
    end

    test "delete_movement/1 deletes the movement" do
      movement = insert(:movements) |> forget(:process)
      assert {:ok, %Movement{}} = Movements.delete_movement(movement)
      assert_raise Ecto.NoResultsError, fn -> Movements.get_movement!(movement.id) end
    end

    test "change_movement/1 returns a movement changeset" do
      movement = insert(:movements) |> forget(:process)
      assert %Ecto.Changeset{} = Movements.change_movement(movement)
    end
  end
end
