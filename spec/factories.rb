FactoryGirl.define do
	factory :user do
		name "Tom York"
		email "tom.york@aef.aef"
		id_num "012345678"
		organization "事業開発部"
		password "foobarrr"
		password_confirmation "foobarrr"
	end
end