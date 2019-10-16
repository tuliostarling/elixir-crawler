defmodule CrawlerChallenge.ProcessesTest do
  use CrawlerChallenge.DataCase

  alias CrawlerChallenge.{NebulexCache, Processes, Repo}

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

    test "get_process_by_number/1 dont return the process with non existing given number" do
      refute Processes.get_process_by_number("0067154-55.2010.8.02.0001")
    end

    test "get_process_by_id_and_preload/2 returns the process preloaded with the given id" do
      court = insert(:courts)
      process = insert(:process, court: court)

      assert Processes.get_process_by_id_and_preload(process, [:details, :movements, :parties]) ==
               process |> forget(:court) |> Repo.preload([:details, :movements, :parties])
    end

    test "valid_process_number/1 returns {:error, :invalid_process_number} when string is empty" do
      assert {:error, :invalid_process_number} = Processes.valid_process_number("")
    end

    test "valid_process_number/1 returns {:error, :invalid_process_number} when string dont have 25 characters" do
      assert {:error, :invalid_process_number} = Processes.valid_process_number("111")
    end

    test "valid_process_number/1 returns {:error, :invalid_process_number} when string dont have the rigth structure" do
      assert {:error, :invalid_process_number} =
               Processes.valid_process_number("1111111-22.3333.802123112")
    end

    test "valid_process_number/1 returns {:error, :invalid_process_number} when string have letters" do
      assert {:error, :invalid_process_number} =
               Processes.valid_process_number("1111111-iy.tttt.8.02.123112")
    end

    test "valid_process_number/1 returns {:ok, :valid_process_number} when string is ok" do
      process = insert(:process)
      assert {:ok, :valid_process_number} = Processes.valid_process_number(process.process_number)
    end

    test "validate_date/1 returs {:invalid, nil} when it is nil" do
      process = nil
      assert {:invalid, nil} = Processes.validate_date(process)
    end

    test "validate_date/1 returs {:invalid, nil} when it does not exists" do
      process = insert(:another_process)
      assert {:invalid, nil} = Processes.validate_date(process.process_number)
    end

    test "validate_date/1 returs {:valid, data} when it exists" do
      process = insert(:process)
      NebulexCache.set_cache(process.process_number, process.id)
      assert {:valid, %{id: id}} = Processes.validate_date(process.process_number)
      assert id = process.id
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
               Processes.insert_all_data(process.process_number, court, crawled_data)

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
