defmodule Appnamehere.Database do
    alias Appnamehere.Repo
    alias Ecto.Adapters.SQL
    def create_schema(tenant) do
        SQL.query(Repo, "CREATE SCHEMA \"#{tenant}\"", [])
    end
end