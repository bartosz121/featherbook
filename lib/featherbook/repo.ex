defmodule Featherbook.Repo do
  use Ecto.Repo,
    otp_app: :featherbook,
    adapter: Ecto.Adapters.Postgres
end
