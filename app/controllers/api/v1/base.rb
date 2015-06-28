module API
  module V1
    class Base < Grape::API
      def current_user
        @current_user ||= User.find(session[:user_id])
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless session[:user_id]
      end

      before do
        authenticate!
      end
      mount API::V1::Users
      mount API::V1::Groups
      mount API::V1::Transactions
      # mount API::V1::AnotherResource
    end
  end
end
