defmodule Appnamehere.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :type, :string
    field :user_id, :string
    has_many :posts, Appnamehere.Blog.Post

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :user_id, :type])
    |> validate_required([:first_name, :last_name, :email, :user_id, :type])
    |> unique_constraint(:user_id)
  end
end
