defmodule TaskAppAuth.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TaskAppAuth.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
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
        zip_code: 42
      })
      |> TaskAppAuth.Accounts.create_account()

    account
  end
end
