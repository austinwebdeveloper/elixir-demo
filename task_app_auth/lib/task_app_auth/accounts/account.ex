defmodule TaskAppAuth.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "account" do
    field(:city, :string)
    field(:dob, :string)
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:password, :string)
    field(:phone_number, :string)
    field(:ssn, :string)
    field(:state, :string)
    field(:street_address, :string)
    field(:zip_code, :integer)
    field(:image_upload, :string)

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [
      :first_name,
      :last_name,
      :email,
      :dob,
      :phone_number,
      :street_address,
      :zip_code,
      :city,
      :state,
      :password,
      :ssn,
      :image_upload
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :dob,
      :phone_number,
      :street_address,
      :zip_code,
      :city,
      :state,
      :password,
      :ssn
    ])
  end
end
