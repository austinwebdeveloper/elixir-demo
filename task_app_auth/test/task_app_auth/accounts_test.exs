defmodule TaskAppAuth.AccountsTest do
  use TaskAppAuth.DataCase

  alias TaskAppAuth.Accounts

  describe "account" do
    alias TaskAppAuth.Accounts.Account

    import TaskAppAuth.AccountsFixtures

    @invalid_attrs %{city: nil, dob: nil, email: nil, first_name: nil, last_name: nil, password: nil, phone_number: nil, ssn: nil, state: nil, street_address: nil, zip_code: nil}

    test "list_account/0 returns all account" do
      account = account_fixture()
      assert Accounts.list_account() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{city: "some city", dob: "some dob", email: "some email", first_name: "some first_name", last_name: "some last_name", password: "some password", phone_number: "some phone_number", ssn: "some ssn", state: "some state", street_address: "some street_address", zip_code: 42}

      assert {:ok, %Account{} = account} = Accounts.create_account(valid_attrs)
      assert account.city == "some city"
      assert account.dob == "some dob"
      assert account.email == "some email"
      assert account.first_name == "some first_name"
      assert account.last_name == "some last_name"
      assert account.password == "some password"
      assert account.phone_number == "some phone_number"
      assert account.ssn == "some ssn"
      assert account.state == "some state"
      assert account.street_address == "some street_address"
      assert account.zip_code == 42
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{city: "some updated city", dob: "some updated dob", email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", password: "some updated password", phone_number: "some updated phone_number", ssn: "some updated ssn", state: "some updated state", street_address: "some updated street_address", zip_code: 43}

      assert {:ok, %Account{} = account} = Accounts.update_account(account, update_attrs)
      assert account.city == "some updated city"
      assert account.dob == "some updated dob"
      assert account.email == "some updated email"
      assert account.first_name == "some updated first_name"
      assert account.last_name == "some updated last_name"
      assert account.password == "some updated password"
      assert account.phone_number == "some updated phone_number"
      assert account.ssn == "some updated ssn"
      assert account.state == "some updated state"
      assert account.street_address == "some updated street_address"
      assert account.zip_code == 43
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_account(account, @invalid_attrs)
      assert account == Accounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounts.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end
end
