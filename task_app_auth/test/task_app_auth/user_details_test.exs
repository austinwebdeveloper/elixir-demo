defmodule TaskAppAuth.UserDetailsTest do
  use TaskAppAuth.DataCase

  alias TaskAppAuth.UserDetails

  describe "user_detail" do
    alias TaskAppAuth.UserDetails.UserDetail

    import TaskAppAuth.UserDetailsFixtures

    @invalid_attrs %{city: nil, dob: nil, email: nil, first_name: nil, last_name: nil, password: nil, phone_number: nil, ssn: nil, state: nil, street_address: nil, zip_code: nil}

    test "list_user_detail/0 returns all user_detail" do
      user_detail = user_detail_fixture()
      assert UserDetails.list_user_detail() == [user_detail]
    end

    test "get_user_detail!/1 returns the user_detail with given id" do
      user_detail = user_detail_fixture()
      assert UserDetails.get_user_detail!(user_detail.id) == user_detail
    end

    test "create_user_detail/1 with valid data creates a user_detail" do
      valid_attrs = %{city: "some city", dob: "some dob", email: "some email", first_name: "some first_name", last_name: "some last_name", password: "some password", phone_number: "some phone_number", ssn: "some ssn", state: "some state", street_address: "some street_address", zip_code: "some zip_code"}

      assert {:ok, %UserDetail{} = user_detail} = UserDetails.create_user_detail(valid_attrs)
      assert user_detail.city == "some city"
      assert user_detail.dob == "some dob"
      assert user_detail.email == "some email"
      assert user_detail.first_name == "some first_name"
      assert user_detail.last_name == "some last_name"
      assert user_detail.password == "some password"
      assert user_detail.phone_number == "some phone_number"
      assert user_detail.ssn == "some ssn"
      assert user_detail.state == "some state"
      assert user_detail.street_address == "some street_address"
      assert user_detail.zip_code == "some zip_code"
    end

    test "create_user_detail/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserDetails.create_user_detail(@invalid_attrs)
    end

    test "update_user_detail/2 with valid data updates the user_detail" do
      user_detail = user_detail_fixture()
      update_attrs = %{city: "some updated city", dob: "some updated dob", email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", password: "some updated password", phone_number: "some updated phone_number", ssn: "some updated ssn", state: "some updated state", street_address: "some updated street_address", zip_code: "some updated zip_code"}

      assert {:ok, %UserDetail{} = user_detail} = UserDetails.update_user_detail(user_detail, update_attrs)
      assert user_detail.city == "some updated city"
      assert user_detail.dob == "some updated dob"
      assert user_detail.email == "some updated email"
      assert user_detail.first_name == "some updated first_name"
      assert user_detail.last_name == "some updated last_name"
      assert user_detail.password == "some updated password"
      assert user_detail.phone_number == "some updated phone_number"
      assert user_detail.ssn == "some updated ssn"
      assert user_detail.state == "some updated state"
      assert user_detail.street_address == "some updated street_address"
      assert user_detail.zip_code == "some updated zip_code"
    end

    test "update_user_detail/2 with invalid data returns error changeset" do
      user_detail = user_detail_fixture()
      assert {:error, %Ecto.Changeset{}} = UserDetails.update_user_detail(user_detail, @invalid_attrs)
      assert user_detail == UserDetails.get_user_detail!(user_detail.id)
    end

    test "delete_user_detail/1 deletes the user_detail" do
      user_detail = user_detail_fixture()
      assert {:ok, %UserDetail{}} = UserDetails.delete_user_detail(user_detail)
      assert_raise Ecto.NoResultsError, fn -> UserDetails.get_user_detail!(user_detail.id) end
    end

    test "change_user_detail/1 returns a user_detail changeset" do
      user_detail = user_detail_fixture()
      assert %Ecto.Changeset{} = UserDetails.change_user_detail(user_detail)
    end
  end
end
