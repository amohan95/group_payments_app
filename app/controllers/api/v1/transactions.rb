module API
  module V1
    class Transactions < Grape::API
      include API::V1::Defaults
      resource :transactions do
      	desc "Creates a new transaction."
      	params do
      		requires :group_id, type: String, desc: "Group ID", , allow_blank: false
      		requires :description, type: String, desc: "Transaction description", allow_blank: false
    		  requires :transaction_map, type: Hash, desc: "Transaction map" do
				    requires :user_id, type: String, desc: "User ID", allow_blank: false
				    requires :amount, type: Integer, desc: "Charge amount", allow_blank: false
				  end
      	end
      	post do
      		#stub
      	end


      	route_param :id do
	      	desc "Edits a transaction."
	      	params do
	      		requires :transaction_map, type: Hash, desc: "Transaction map" do
				    	requires :user_id, type: String, desc: "User ID", allow_blank: false
				    	requires :amount, type: Integer, desc: "Charge amount", allow_blank: false
				  	end
	      	end
	      	put do
	      		#stub
	      	end
	      end


	      route_param :id do
	      	desc "Removes a transaction."
	      	delete do
	      		#stub
	      	end
	      end
      end
    end
  end
end