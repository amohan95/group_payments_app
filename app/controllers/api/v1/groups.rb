module API
  module V1
    class Groups < Grape::API
      include API::V1::Defaults

      resource :groups do
        # /groups/
        desc 'Create a new group'
        params do
          requires :users, type: Array, desc: 'A list of users that will be' \
            ' a part of the group'
          optional :name, type: String, desc: 'A name that identifies the' \
            ' group', allow_blank: false
        end
        post do
          # stub
        end

        # /groups/:id/
        params do
          requires :id, type: Integer, desc: 'The id of the group'
        end
        route_param :id do
          desc 'Retrieves information about the specified group'
          get do
            # stub
          end

          desc 'Updates the name or the members of the specified group'
          params do
            optional :name, type: String, desc: 'The new name of the group',
              allow_blank: false
            optional :added_users, type: Array, desc: 'Users to be added to' \
              ' the group'
            optional :removed_users, type: Array, desc: 'Users to be removed' \
              ' from the group'
            at_least_one_of :name, :added_users, :removed_users
          end
          put do
            # stub
          end

          desc 'Delete the specified group'
          delete do
            # stub
          end

          # /groups/:id/transactions/
          resource :transactions do
            desc 'Retrieves all transactions for the specified group'
            params do
              optional :other_user, type: Integer, desc: 'The id of the user' \
                'in the group'
            end
            get do
              # stub
            end
          end
        end
      end
    end
  end
end
