defmodule CrawlerChallenge.DetailsTest do
  use CrawlerChallenge.DataCase

  alias CrawlerChallenge.Details

  describe "details" do
    alias CrawlerChallenge.Details.Detail

    @valid_attrs %{
      area: "some area",
      class: "some class",
      distribution_date: ~N[2010-04-17 14:00:00],
      judge: "some judge",
      process_number: 42,
      stock_price: 42,
      subject: "some subject"
    }
    @update_attrs %{
      area: "some updated area",
      class: "some updated class",
      distribution_date: ~N[2011-05-18 15:01:01],
      judge: "some updated judge",
      process_number: 43,
      stock_price: 43,
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

    def detail_fixture(attrs \\ %{}) do
      {:ok, detail} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Details.create_detail()

      detail
    end

    test "list_details/0 returns all details" do
      detail = detail_fixture()
      assert Details.list_details() == [detail]
    end

    test "get_detail!/1 returns the detail with given id" do
      detail = detail_fixture()
      assert Details.get_detail!(detail.id) == detail
    end

    test "create_detail/1 with valid data creates a detail" do
      assert {:ok, %Detail{} = detail} = Details.create_detail(@valid_attrs)
      assert detail.area == "some area"
      assert detail.class == "some class"
      assert detail.distribution_date == ~N[2010-04-17 14:00:00]
      assert detail.judge == "some judge"
      assert detail.process_number == 42
      assert detail.stock_price == 42
      assert detail.subject == "some subject"
    end

    test "create_detail/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Details.create_detail(@invalid_attrs)
    end

    test "update_detail/2 with valid data updates the detail" do
      detail = detail_fixture()
      assert {:ok, %Detail{} = detail} = Details.update_detail(detail, @update_attrs)
      assert detail.area == "some updated area"
      assert detail.class == "some updated class"
      assert detail.distribution_date == ~N[2011-05-18 15:01:01]
      assert detail.judge == "some updated judge"
      assert detail.process_number == 43
      assert detail.stock_price == 43
      assert detail.subject == "some updated subject"
    end

    test "update_detail/2 with invalid data returns error changeset" do
      detail = detail_fixture()
      assert {:error, %Ecto.Changeset{}} = Details.update_detail(detail, @invalid_attrs)
      assert detail == Details.get_detail!(detail.id)
    end

    test "delete_detail/1 deletes the detail" do
      detail = detail_fixture()
      assert {:ok, %Detail{}} = Details.delete_detail(detail)
      assert_raise Ecto.NoResultsError, fn -> Details.get_detail!(detail.id) end
    end

    test "change_detail/1 returns a detail changeset" do
      detail = detail_fixture()
      assert %Ecto.Changeset{} = Details.change_detail(detail)
    end
  end
end
