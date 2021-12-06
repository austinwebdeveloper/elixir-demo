defmodule TaskAppAuth.Repo.Migrations.CreateUserDetail do
  use Ecto.Migration

  def change do
    create table(:user_detail) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :dob, :string
      add :phone_number, :string
      add :street_address, :string
      add :zip_code, :string
      add :city, :string
      add :state, :string
      add :password, :string
      add :ssn, :string

      timestamps()
    end
  end
end
