defmodule Appnamehere.Auth.Pipeline do
    use Guardian.Plug.Pipeline,
        otp_app: :appnamehere,
        module: Appnamehere.Guardian,
        error_handler: Appnamehere.Auth.ErrorHandler
        
  # # If there is a session token, validate it
  # plug Guardian.Plug.VerifySession, claims: %{"user" => "access"}
  # # If there is an authorization header, validate it
  # plug Guardian.Plug.VerifyHeader, claims: %{"user" => "access"}
  # # Load the user if either of the verifications worked
  # plug Guardian.Plug.LoadResource, allow_blank: true
  plug Guardian.Plug.VerifyHeader, realm: :none
  plug Guardian.Plug.LoadResource
  # plug Guardian.Plug.EnsureAuthenticated
end