module API
  module V1
    class Groups < Grape::API
      include API::V1::Defaults

      resource :groups do
        # /groups/
        desc 'Create a new group'
        params do
          requires :users, type: Array[Integer], desc: 'A list of users that' \
            'will be a part of the group'
          optional :name, type: String, desc: 'A name that identifies the' \
            ' group', allow_blank: false
        end
        post do
          if params[:name]
            group = Group.create(name: params[:name])
          else
            group = Group.create()
          end
          group.users = User.where(fb_user_id: params[:users])
          group.save
          group
        end

        # /groups/:id/
        params do
          requires :id, type: Integer, desc: 'The id of the group'
        end
        route_param :id do
          desc 'Retrieves information about the specified group'
          get do
            Group.find(params[:id])
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
            group = Group.find(params[:id])
            if params[:name]
              group.name = name
            end
            if params[:added_users]
              group.users.concat User.where(fb_user_id: params[:added_users])
            end
            if params[:removed_users]
              group.users = group.users - User.where(fb_user_id:
                params[:removed_users])
            end
            group.save
          end

          desc 'Delete the specified group'
          delete do
            Group.destroy(params[:id])
          end

          # /groups/:id/transactions/
          resource :transactions do
            desc 'Retrieves all transactions for the specified group'
            params do
              optional :other_user, type: Integer, desc: 'The id of the user' \
                'in the group'
            end
            get do
              if params[:other_user]
                user_transactions = UserTransaction.where('user_id=? AND' \
                  'other_user_id=? OR user_id=? AND other_user_id=?',
                  current_user.id, params[:other_user],
                  params[:other_user], current_user.id)
              else
                user_transactions = GroupTransaction.where('user_id=? OR' \
                  'other_user_id=?', current_user.id, current_user.id)
              end
              GroupTransaction.where(id: user_transactions.pluck(:id))
            end
          end
        end
      end
    end
  end
end
