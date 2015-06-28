module API
  class Base < Grape::API
    helpers do
      def current_user
        @current_user ||= User.find(session[:user_id])
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless session[:user_id]
      end
    end
    mount API::V1::Base
  end
end
