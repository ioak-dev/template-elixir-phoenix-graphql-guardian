defmodule AppnamehereWeb.Schema.Types.UserType do
    use Absinthe.Schema.Notation

    object :user_type do
        field :id, non_null(:id)
        field :user_id, :string
        field :first_name, :string
        field :last_name, :string
        field :email, :string
        field :type, :string
    end

    input_object :user_input_type do
        field :user_id, non_null(:string)
        field :first_name, non_null(:string)
        field :last_name, non_null(:string)
        field :email, non_null(:string)
        field :type, non_null(:string)
    end
end