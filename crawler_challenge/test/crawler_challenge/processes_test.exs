defmodule CrawlerChallenge.ProcessesTest do
  use CrawlerChallenge.DataCase

  alias CrawlerChallenge.Processes
  alias CrawlerChallenge.Repo

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

    test "get_process_by_number/1 returns the process with the given number" do
      court = insert(:courts)
      process = insert(:process, court: court)
      assert Processes.get_process_by_number(process.process_number) == process |> forget(:court)
    end

    test "get_process_by_id_and_preload/2 returns the process preloaded with the given id" do
      court = insert(:courts)
      process = insert(:process, court: court)

      assert Processes.get_process_by_id_and_preload(process, [:details, :movements, :parties]) ==
               process |> forget(:court) |> Repo.preload([:details, :movements, :parties])
    end

    test "validate_date/1 returs {:invalid, nil} when it does not exists" do
      process = nil
      assert {:invalid, nil} = Processes.validate_date(process)
    end

    test "check_expiration/1 returns {:valid, data} when process isn't more than 24h in db" do
      process = insert(:valid_process)

      %{id: _id} = process

      assert {:valid, data} = Processes.check_expiration(process)
      assert id = data.id
    end

    test "check_expiration/1 returns {:invalid, nil} when process isn't more than 24h in db" do
      process = insert(:invalid_process)

      assert {:invalid, nil} = Processes.check_expiration(process)
    end

    test "get_last_process_and_preload/1 return last process and preload the associations" do
      court = insert(:courts)
      process = insert(:process, court: court)

      assert %{id: id} = Processes.get_last_process_and_preload([:movements, :details, :parties])
      assert id = process.id
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

    test "insert_all_data/3 returns crawled_data" do
      court = insert(:courts)
      process = insert(:process, court: court)

      crawled_data = [
        list_movements: [%{"movement" => "test", "movement_date" => "20/10/2019"}],
        list_parties: [
          %{
            "name" => "Luke Skywalker",
            "partie" => "jedi",
            "position" => "Dark side of the Force",
            "person_name_position" => "Darth Vader"
          }
        ],
        list_details: %{
          "process_number" => "0000000001",
          "area" => "test area",
          "class" => "some class",
          "distribution_date" => "20/12/2012",
          "stock_price" => "1.100,00",
          "subject" => "Take Luke to the Dark Side of the Force"
        }
      ]

      assert {:ok, crawled_data} =
               Processes.insert_all_data(process.process_number, court.name, crawled_data)

      %{id: _id} = process

      assert "Take Luke to the Dark Side of the Force" = crawled_data.detail.subject
      assert id = crawled_data.detail.process_id
      assert 1 = crawled_data.movement
      assert 1 = crawled_data.parties
      assert id = crawled_data.process.id
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
