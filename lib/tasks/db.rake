namespace :db do
  desc "TODO"
  task sample: :environment do
  	# Create Users
  	users = Array.new

  	users << User.create(fb_user_id: '00000000000')
  	users << User.create(fb_user_id: '11111111111')
  	users << User.create(fb_user_id: '22222222222')
  	users << User.create(fb_user_id: '33333333333')
  	users << User.create(fb_user_id: '44444444444')

  	groups = Array.new

  	# Create Groups
  	groups << Group.create(name: 'Group 0')

  	groups << Group.create(name: 'Group 1')

  	groups << Group.create(name: 'Group 2')

  	# Create UserGroups
  	usergroups = Array.new

  	usergroups << UserGroup.create(
			user_id: users[0].id,
			group: groups[0]
		)
  	usergroups << UserGroup.create(
			user: users[1],
			group: groups[0]
		)
		usergroups << UserGroup.create(
			user: users[2],
			group: groups[0]
		)
		usergroups << UserGroup.create(
			user: users[3],
			group: groups[0]
		)
		usergroups << UserGroup.create(
			user: users[4],
			group: groups[0]
		)
		usergroups << UserGroup.create(
			user: users[0],
			group: groups[1]
		)
		usergroups << UserGroup.create(
			user: users[1],
			group: groups[1]
		)
		usergroups << UserGroup.create(
			user: users[0],
			group: groups[2]
		)
		usergroups << UserGroup.create(
			user: users[2],
			group: groups[2]
		)

		# Add usergroups to users
		users[0].user_groups = [usergroups[0], usergroups[5], usergroups[7]]
		users[0].save

		users[1].user_groups = [usergroups[1], usergroups[6]]
		users[1].save

		users[2].user_groups = [usergroups[2], usergroups[8]]
		users[2].save

		users[3].user_groups = [usergroups[3]]
		users[3].save

		users[4].user_groups = [usergroups[4]]
		users[4].save

		# Add usergroups to groups
  	groups[0].user_groups = usergroups[0,5]
  	groups[0].save

  	groups[1].user_groups = usergroups[5,2]
  	groups[1].save

  	groups[2].user_groups = usergroups[7,2]
  	groups[2].save

  	# Add transactions
  	# Adds two transactions to group 1.
		gt = GroupTransaction.create(
  		purpose: "Test 1",
  		group: groups[1],
  		user: users[0],
  	)
  	ut = UserTransaction.create(
  		amount: 100,
  		settled: false,
  		group_transaction: gt,
  		user: users[0],
  		other_user: users[1]
  	)
  	gt.user_transactions = [ut]
  	gt.save
  	
  	gt = GroupTransaction.create(
  		purpose: "Test 2",
  		group_id: groups[1],
  		user_id: users[1],
  	)
  	ut = UserTransaction.create(
  		amount: 200,
  		settled: false,
  		group_transaction: gt,
  		user: users[1],
  		other_user: users[0]
  	)
  	gt.user_transactions = [ut]
  	gt.save
  end

end
