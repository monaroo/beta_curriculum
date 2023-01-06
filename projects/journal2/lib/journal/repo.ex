defmodule Journal.Repo do
  use Ecto.Repo,
    otp_app: :journal2,
    adapter: Ecto.Adapters.Postgres
end
