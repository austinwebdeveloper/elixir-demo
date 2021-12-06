defmodule TaskAppAuthWeb.UserDetailLiveTest do
  use TaskAppAuthWeb.ConnCase

  import Phoenix.LiveViewTest
  import TaskAppAuth.UserDetailsFixtures

  @create_attrs %{city: "some city", dob: "some dob", email: "some email", first_name: "some first_name", last_name: "some last_name", password: "some password", phone_number: "some phone_number", ssn: "some ssn", state: "some state", street_address: "some street_address", zip_code: "some zip_code"}
  @update_attrs %{city: "some updated city", dob: "some updated dob", email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", password: "some updated password", phone_number: "some updated phone_number", ssn: "some updated ssn", state: "some updated state", street_address: "some updated street_address", zip_code: "some updated zip_code"}
  @invalid_attrs %{city: nil, dob: nil, email: nil, first_name: nil, last_name: nil, password: nil, phone_number: nil, ssn: nil, state: nil, street_address: nil, zip_code: nil}

  defp create_user_detail(_) do
    user_detail = user_detail_fixture()
    %{user_detail: user_detail}
  end

  describe "Index" do
    setup [:create_user_detail]

    test "lists all user_detail", %{conn: conn, user_detail: user_detail} do
      {:ok, _index_live, html} = live(conn, Routes.user_detail_index_path(conn, :index))

      assert html =~ "Listing User detail"
      assert html =~ user_detail.city
    end

    test "saves new user_detail", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.user_detail_index_path(conn, :index))

      assert index_live |> element("a", "New User detail") |> render_click() =~
               "New User detail"

      assert_patch(index_live, Routes.user_detail_index_path(conn, :new))

      assert index_live
             |> form("#user_detail-form", user_detail: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#user_detail-form", user_detail: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_detail_index_path(conn, :index))

      assert html =~ "User detail created successfully"
      assert html =~ "some city"
    end

    test "updates user_detail in listing", %{conn: conn, user_detail: user_detail} do
      {:ok, index_live, _html} = live(conn, Routes.user_detail_index_path(conn, :index))

      assert index_live |> element("#user_detail-#{user_detail.id} a", "Edit") |> render_click() =~
               "Edit User detail"

      assert_patch(index_live, Routes.user_detail_index_path(conn, :edit, user_detail))

      assert index_live
             |> form("#user_detail-form", user_detail: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#user_detail-form", user_detail: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_detail_index_path(conn, :index))

      assert html =~ "User detail updated successfully"
      assert html =~ "some updated city"
    end

    test "deletes user_detail in listing", %{conn: conn, user_detail: user_detail} do
      {:ok, index_live, _html} = live(conn, Routes.user_detail_index_path(conn, :index))

      assert index_live |> element("#user_detail-#{user_detail.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user_detail-#{user_detail.id}")
    end
  end

  describe "Show" do
    setup [:create_user_detail]

    test "displays user_detail", %{conn: conn, user_detail: user_detail} do
      {:ok, _show_live, html} = live(conn, Routes.user_detail_show_path(conn, :show, user_detail))

      assert html =~ "Show User detail"
      assert html =~ user_detail.city
    end

    test "updates user_detail within modal", %{conn: conn, user_detail: user_detail} do
      {:ok, show_live, _html} = live(conn, Routes.user_detail_show_path(conn, :show, user_detail))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User detail"

      assert_patch(show_live, Routes.user_detail_show_path(conn, :edit, user_detail))

      assert show_live
             |> form("#user_detail-form", user_detail: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#user_detail-form", user_detail: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_detail_show_path(conn, :show, user_detail))

      assert html =~ "User detail updated successfully"
      assert html =~ "some updated city"
    end
  end
end
