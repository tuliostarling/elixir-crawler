defmodule CrawlerChallenge.DetailsTest do
  use CrawlerChallenge.DataCase

  alias CrawlerChallenge.Details

  import CrawlerChallenge.Unpreloader

  describe "details" do
    alias CrawlerChallenge.Details.Detail

    @update_attrs %{
      area: "some updated area",
      class: "some updated class",
      distribution_date: "2017-04-17",
      judge: "some updated judge",
      stock_price: "49,00",
      subject: "some updated subject"
    }
    @invalid_attrs %{
      area: nil,
      class: nil,
      distribution_date: nil,
      judge: nil,
      process_number: nil,
      stock_price: nil,
      subject: nil
    }

    test "list_details/0 returns all details" do
      detail = insert(:details) |> forget(:process)
      assert Details.list_details() == [detail]
    end

    test "get_detail!/1 returns the detail with given id" do
      detail = insert(:details)
      assert Details.get_detail!(detail.id) == detail |> forget(:process)
    end

    test "create_detail/1 with valid data creates a detail" do
      valid_attrs = params_with_assocs(:details)
      assert {:ok, %Detail{} = detail} = Details.create_detail(valid_attrs)
      assert detail.process_number == "0000575-40.2014.8.02.0081"
      assert detail.distribution_date == "14/10/2019"
      assert detail.stock_price == "1.100,00"
    end

    test "create_detail/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Details.create_detail(@invalid_attrs)
    end

    test "update_detail/2 with valid data updates the detail" do
      detail = insert(:details) |> forget(:process)
      assert {:ok, %Detail{} = detail} = Details.update_detail(detail, @update_attrs)
      assert detail.area == "some updated area"
      assert detail.class == "some updated class"
      assert detail.distribution_date == "2017-04-17"
      assert detail.judge == "some updated judge"
      assert detail.stock_price == "49,00"
      assert detail.subject == "some updated subject"
    end

    test "update_detail/2 with invalid data returns error changeset" do
      detail = insert(:details) |> forget(:process)
      assert {:error, %Ecto.Changeset{}} = Details.update_detail(detail, @invalid_attrs)
      assert detail == Details.get_detail!(detail.id)
    end

    test "delete_detail/1 deletes the detail" do
      detail = insert(:details) |> forget(:process)
      assert {:ok, %Detail{}} = Details.delete_detail(detail)
      assert_raise Ecto.NoResultsError, fn -> Details.get_detail!(detail.id) end
    end

    test "change_detail/1 returns a detail changeset" do
      detail = insert(:details) |> forget(:process)
      assert %Ecto.Changeset{} = Details.change_detail(detail)
    end
  end
end
