defmodule CrawlerChallenge.ProcessesTest do
  use CrawlerChallenge.DataCase

  alias CrawlerChallenge.Processes

  describe "processes" do
    alias CrawlerChallenge.Processes.Process

    # @valid_attrs %{process_number: 42}
    # @update_attrs %{process_number: 43}
    # @invalid_attrs %{process_number: nil}

    # @valid_attrs params_for(:process)
    # @update_attrs params_for(:process, process_number: "0717561-98.2019.8.02.0001")
    # @invalid_attrs %{process_number: ""}
    @valid_attrs %{court_id: 1, process_number: "0000575-40.2014.8.02.0081"}
    @update_attrs %{process_number: "0717561-98.2019.8.02.0001"}
    @invalid_attrs %{process_number: ""}

    def process_fixture(attrs \\ %{}) do
      {:ok, process} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Processes.create_process()

      process
    end

    test "list_processes/0 returns all processes" do
      process = process_fixture()
      assert Processes.list_processes() == [process]
    end

    test "get_process!/1 returns the process with given id" do
      process = process_fixture()
      assert Processes.get_process!(process.id) == process
    end

    test "create_process/1 with valid data creates a process" do
      assert {:ok, %Process{} = process} = Processes.create_process(@valid_attrs)
      assert process.process_number == "0000575-40.2014.8.02.0081"
    end

    test "create_process/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Processes.create_process(@invalid_attrs)
    end

    test "update_process/2 with valid data updates the process" do
      process = process_fixture()
      assert {:ok, %Process{} = process} =
        Processes.update_process(process, @update_attrs)
      assert process.process_number == "0717561-98.2019.8.02.0001"
    end

    test "update_process/2 with invalid data returns error changeset" do
      process = process_fixture()
      assert {:error, %Ecto.Changeset{}} =
        Processes.update_process(process, @invalid_attrs)
      assert process == Processes.get_process!(process.id)
    end

    test "delete_process/1 deletes the process" do
      process = process_fixture()
      assert {:ok, %Process{}} = Processes.delete_process(process)
      assert_raise Ecto.NoResultsError, fn -> Processes.get_process!(process.id) end
    end

    test "change_process/1 returns a process changeset" do
      process = process_fixture()
      assert %Ecto.Changeset{} = Processes.change_process(process)
    end
  end
end
