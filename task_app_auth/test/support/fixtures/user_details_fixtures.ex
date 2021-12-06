defmodule TaskAppAuth.UserDetailsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TaskAppAuth.UserDetails` context.
  """

  @doc """
  Generate a user_detail.
  """
  def user_detail_fixture(attrs \\ %{}) do
    {:ok, user_detail} =
      attrs
      |> Enum.into(%{
        city: "some city",
        dob: "some dob",
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        password: "some password",
        phone_number: "some phone_number",
        ssn: "some ssn",
        state: "some state",
        street_address: "some street_address",
        zip_code: "some zip_code"
      })
      |> TaskAppAuth.UserDetails.create_user_detail()

    user_detail
  end
end
