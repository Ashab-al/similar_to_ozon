module ApiHelper
  module Request

    def jwt_token(user_id)
      {
        'session-token': JWT.encode(
          {
            uuid: user_id
          },
          Rails.application.credentials.devise_jwt_secret_key!,
          'HS512'
         )
      }
    end

    def external_jwt_token(user_id)
      {
        'api-token': JWT.encode(
          {
            uuid: user_id
          },
          Rails.application.credentials.devise_jwt_secret_key!,
          'HS512'
        )
      }
    end
  end
end