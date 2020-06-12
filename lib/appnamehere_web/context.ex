defmodule AppnamehereWeb.Context do
    @behaviour Plug

    import Plug.Conn
    alias Appnamehere.Guardian

    def init(opts) do
        opts    
    end

    def call(conn, _) do
       context = build_context(conn)
       Absinthe.Plug.put_options(conn, context: context)
    end

    def build_context(conn) do
        case get_req_header(conn, "authorization") |> authorize do
            {:ok, claims} -> %{user: claims}
            {:error, _} -> %{user: nil}
        end

        # with [token] <- get_req_header(conn, "authorization"),
        # {:ok, claims} <- authorize(token) do
        #     %{user: claims}
        # else
        #     nil -> {:error, "Unauthorized"}
        # end
    end

    defp authorize([token]) do
        case Guardian.decode_and_verify(token, %{}, secret: "jwtsecret") do
            { :ok, claims } -> {:ok, claims}
            { :error, reason } -> {:error, reason}
            nil -> {:error, "Unauthorized"}
        end
    end

    defp authorize(_token) do
        {:error, "no token"}
    end
    
end