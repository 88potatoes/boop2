defmodule Boop.Repo do
  use Ecto.Repo,
    otp_app: :boop,
    adapter: Ecto.Adapters.Postgres
end
