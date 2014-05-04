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
end