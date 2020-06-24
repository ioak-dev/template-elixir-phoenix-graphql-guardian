defmodule AppnamehereWeb.BlogResolver do
    alias Appnamehere.Blog

    def all_posts(_root, _args, %{context: %{space: space}}) do
        case space do
            nil -> {:error, "Space is missing"}
            _-> {:ok, Blog.list_posts(space)}
        end
    end

    def post(_root, args, %{context: %{space: space}}) do
        case space do
            nil -> {:error, "Space is missing"}
            _-> 
            try do
                post = Blog.get_post!(space, args.id)
                {:ok, post}
            rescue
                Ecto.NoResultsError -> {:ok, nil}
            end
        end
    end

    # def user_by_user_id(_root, args, _info) do
    #     user = Accounts.get_user_by_user_id!(210, args.user_id)
    #     {:ok, user}
    # end

    def create_post(_root, args, %{context: %{space: space, user: user}}) do
        case space do
            nil -> {:error, "Space is missing"}
            _-> 
            args.payload |> Map.merge(%{user_id: user["userId"]})
            case Blog.create_post(210, args.payload |> Map.merge(%{user_id: "7"})) do
                {:ok, post} -> {:ok, post}
                _error -> {:error, "error creating post"}
            end
        end
    end
end