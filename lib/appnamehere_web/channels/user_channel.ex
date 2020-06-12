defmodule AppnamehereWeb.UserChannel do
  use AppnamehereWeb, :channel

  def join("user:" <> id, _payload, socket) do
    socket.assigns[:user_id]
    IO.inspect(id)
    if socket.assigns[:user_id] == id do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("new_message", payload, socket) do
    broadcast socket, "new_message", payload
    {:reply, {:ok, %{response: payload}}, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:noreply, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
