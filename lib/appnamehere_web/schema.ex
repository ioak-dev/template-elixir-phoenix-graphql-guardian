defmodule AppnamehereWeb.Schema do
    use Absinthe.Schema

    alias AppnamehereWeb.AccountsResolver

    import_types(AppnamehereWeb.Schema.Types)

    query do
        field :all_users, non_null(list_of(non_null(:user_type))) do
            resolve &AccountsResolver.all_users/3
        end
        field :user, :user_type do
            arg :id, non_null(:id)
            resolve &AccountsResolver.user/3
        end
        field :user_by_user_id, :user_type do
            arg :user_id, non_null(:id)
            resolve &AccountsResolver.user_by_user_id/3
        end
    end

    mutation do
        field :create_user, :user_type do
            arg :payload, :user_input_type
            resolve &AccountsResolver.create_user/3
        end
    end
end