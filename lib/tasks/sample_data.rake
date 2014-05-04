namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!(name: "Example User",
									email: "aef@aef.aef",
									password: "password",
									password_confirmation: "password")
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.jp"
			password = "password"
			User.create!(name: name,
										email: email,
										password: password,
										password_confirmation: password)
		end
	end
end