FactoryGirl.define do
	factory :user do
		sequence(:name) {|n| "Person #{n}"}
		sequence(:email) {|n| "person_#{n}@example.com"}
		id_num "012345678"
		organization "事業開発部"
		password "password"
		password_confirmation "password"

		factory :admin do
			admin true
		end
	end

	factory :company do
		sequence(:name) {|n| "Company_#{n}"}
		sequence(:description) {"This company is just great"}
		founded_date {1.years.ago}
		closed_date {1.days.ago}
		stage "Round A"
	end

	factory :person do
		sequence(:name) {|n| "Peter Rich#{n}"}
		position "CEO"
	end
end