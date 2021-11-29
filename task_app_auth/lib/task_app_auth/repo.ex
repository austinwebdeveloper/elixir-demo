defmodule TaskAppAuth.Repo do
  use Ecto.Repo,
    otp_app: :task_app_auth,
    adapter: Ecto.Adapters.Postgres
end
