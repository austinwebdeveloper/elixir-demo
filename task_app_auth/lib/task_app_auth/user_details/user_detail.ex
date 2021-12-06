defmodule TaskAppAuth.UserDetails.UserDetail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_detail" do
    field :city, :string
    field :dob, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string
    field :phone_number, :string
    field :ssn, :string
    field :state, :string
    field :street_address, :string
    field :zip_code, :string

    timestamps()
  end

  @doc false
  def changeset(user_detail, attrs) do
    user_detail
    |> cast(attrs, [:first_name, :last_name, :email, :dob, :phone_number, :street_address, :zip_code, :city, :state, :password, :ssn])
    |> validate_required([:first_name, :last_name, :email, :dob, :phone_number, :street_address, :zip_code, :city, :state, :password, :ssn])
  end
end
