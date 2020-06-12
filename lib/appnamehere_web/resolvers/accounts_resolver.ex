defmodule AppnamehereWeb.AccountsResolver do
    alias Appnamehere.Accounts

    def all_users(_root, _args, %{context: context}) do
        context.user |> IO.inspect
        users = Accounts.list_users(210) |> IO.inspect
        if context.user == nil do
            {:error, "error"}
        else
            {:ok, users}
        end
    end

    def user(_root, args, _info) do
        try do
            user = Accounts.get_user!(210, args.id) |> IO.inspect
            {:ok, user}
        rescue
            Ecto.NoResultsError -> {:ok, nil}
        end
    end

    def user_by_user_id(_root, args, _info) do
        user = Accounts.get_user_by_user_id!(210, args.user_id)
        {:ok, user}
    end

    def create_user(_root, args, _info) do
        case Accounts.create_user(210, args.payload) do
            {:ok, user} -> {:ok, user}
            _error -> {:error, "error creating user"}
        end
    end
end