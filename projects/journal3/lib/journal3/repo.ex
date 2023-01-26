defmodule Journal3.Repo do
  use Ecto.Repo,
    otp_app: :journal3,
    adapter: Ecto.Adapters.Postgres
end
