module API
  class Base < Grape::API
    helpers do
      def current_user
        @current_user ||= User.find_or_create_from_auth_hash(session[:auth_hash])
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless current_user
      end
    end
    mount API::V1::Base
  end
end
