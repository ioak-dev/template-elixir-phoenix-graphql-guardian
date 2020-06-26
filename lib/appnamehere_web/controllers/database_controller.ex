defmodule AppnamehereWeb.DatabaseController do
    use AppnamehereWeb, :controller
    use HTTPoison.Base
  
    alias Appnamehere.Database
  
    action_fallback AppnamehereWeb.FallbackController
  
    def index(conn, %{"space" => space}) do
      Database.create_schema("appnamehere_#{space}")
      send_resp(conn, :no_content, "")
    end
  
end  