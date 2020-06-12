defmodule AppnamehereWeb.Schema do
    use Absinthe.Schema

    alias AppnamehereWeb.AccountsResolver

    object :user do
        field :id, non_null(:id)
        field :user_id, :string
        field :first_name, :string
        field :last_name, :string
        field :email, :string
    end

    query do
        field :all_users, non_null(list_of(non_null(:user))) do
            resolve &AccountsResolver.all_users/3
        end
        field :user, :user do
            arg :id, non_null(:id)
            resolve &AccountsResolver.user/3
        end
        field :user_by_user_id, :user do
            arg :user_id, non_null(:id)
            resolve &AccountsResolver.user_by_user_id/3
        end
    end

    mutation do
        field :create_user, :user do
            arg :user_id, non_null(:string)
            arg :first_name, non_null(:string)
            arg :last_name, non_null(:string)
            arg :email, non_null(:string)
            arg :type, non_null(:string)

            resolve &AccountsResolver.create_user/3
        end
    end
end