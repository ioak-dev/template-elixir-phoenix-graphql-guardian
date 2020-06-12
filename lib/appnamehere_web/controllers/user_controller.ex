defmodule AppnamehereWeb.UserController do
  use AppnamehereWeb, :controller
  use HTTPoison.Base

  alias Appnamehere.Accounts
  alias Appnamehere.Accounts.User

  action_fallback AppnamehereWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def session(conn, %{"space" => space, "session_id" => session_id}) do
    case HTTPoison.get!("http://127.0.0.1:8020/auth/#{space}/session/#{session_id}") do
      %HTTPoison.Response{status_code: 200, body: body} -> 
        user_from_source = body |> Poison.decode!
        user_params = %{
          email: user_from_source["email"],
          first_name: user_from_source["firstName"],
          last_name: user_from_source["lastName"],
          user_id: user_from_source["userId"],
          type: user_from_source["type"]
        }

        case Accounts.get_user_by_user_id!(user_from_source["userId"]) do 
          %Accounts.User{} = user ->
            {:ok, updated_user} = Accounts.update_user(user, user_params)
            render(conn, "session.json", %{user: updated_user, token: user_from_source["token"]})
          _ ->
            Accounts.create_user(user_params)
        end
      %HTTPoison.Response{status_code: 404, body: body} ->
        send_resp(conn, :not_found, body)
      %HTTPoison.Error{} -> IO.puts("Error")
      _ -> send_resp(conn, :internal_server_error, "unknown error")
    end
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
