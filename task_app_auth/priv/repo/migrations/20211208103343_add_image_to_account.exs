defmodule TaskAppAuth.Repo.Migrations.AddImageToAccount do
  use Ecto.Migration

  def change do
    alter table(:account) do
      add :image_upload, :string
    end
  end
end
