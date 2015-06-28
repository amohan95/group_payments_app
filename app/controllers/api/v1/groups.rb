module API
  module V1
    class Groups < Grape::API
      include API::V1::Defaults
      resource :groups do
      end
    end
  end
end
