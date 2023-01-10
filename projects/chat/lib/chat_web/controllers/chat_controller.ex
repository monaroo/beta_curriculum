defmodule ChatWeb.ChatController do
  use ChatWeb, :controller

  def index(conn, _params) do
    json(conn, %{messages: Chat.Server.list})
  end

  def create(conn, params) do
    msg = Map.get(params, "body")
    status = Chat.Server.post(msg)
    json(conn, %{status: status})
  end
end
