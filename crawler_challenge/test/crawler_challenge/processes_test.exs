defmodule CrawlerChallenge.ProcessesTest do
  use CrawlerChallenge.DataCase

  alias CrawlerChallenge.Processes

  import CrawlerChallenge.Unpreloader

  describe "processes" do
    alias CrawlerChallenge.Processes.Process

    @update_attrs %{process_number: "0717561-98.2019.8.02.0001"}
    @invalid_attrs %{process_number: ""}

    test "list_processes/0 returns all processes" do
      court = insert(:courts)
      process = insert(:process, court: court)
      assert Processes.list_processes() == [process |> forget(:court)]
    end

    test "get_process!/1 returns the process with given id" do
      court = insert(:courts)
      process = insert(:process, court: court)
      assert Processes.get_process!(process.id) == process |> forget(:court)
    end

    test "create_process/1 with valid data creates a process" do
      court = insert(:courts)
      valid_attrs = %{court_id: court.id, process_number: "0000575-40.2014.8.02.0081"}
      assert {:ok, %Process{} = process} = Processes.create_process(valid_attrs)
      assert process.process_number == "0000575-40.2014.8.02.0081"
    end

    test "create_process/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Processes.create_process(@invalid_attrs)
    end

    test "update_process/2 with valid data updates the process" do
      court = insert(:courts)
      process = insert(:process, court: court)
      assert {:ok, %Process{} = process} = Processes.update_process(process, @update_attrs)
      assert process.process_number == "0717561-98.2019.8.02.0001"
    end

    test "update_process/2 with invalid data returns error changeset" do
      court = insert(:courts)
      process = insert(:process, court: court)
      assert {:error, %Ecto.Changeset{}} = Processes.update_process(process, @invalid_attrs)
      assert process |> forget(:court) == Processes.get_process!(process.id)
    end

    test "delete_process/1 deletes the process" do
      court = insert(:courts)
      process = insert(:process, court: court)
      assert {:ok, %Process{}} = Processes.delete_process(process)
      assert_raise Ecto.NoResultsError, fn -> Processes.get_process!(process.id) end
    end

    test "change_process/1 returns a process changeset" do
      court = insert(:courts)
      process = insert(:process, court: court)
      assert %Ecto.Changeset{} = Processes.change_process(process)
    end
  end
end
