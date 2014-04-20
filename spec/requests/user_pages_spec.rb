require 'spec_helper'

describe "UserPages" do

	subject {page}

	describe "signup page" do
		before {visit signup_path}

		it {should have_content('Sign up')}
		it {should have_title('Monitoring DB | Sign up')}
	end

	describe "signup" do
		before {visit signup_path}
		let(:submit) {"Submit"}

		describe "with invalid information" do
			it "should not create a user" do
				expect {click_button submit}.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "名前", with: "Tom York"
				fill_in "Eメール", with: "tom.york@aef.aef"
				fill_in "社員番号", with: "012345678"
				fill_in "所属組織", with: "事業開発部"
				fill_in "パスワード", with: "foobarrr"
				fill_in "パスワード確認", with: "foobarrr"
			end

			it "should create a user" do
				expect {click_button submit}.to change(User, :count).by(1)
			end
		end
	end

	describe "profile page" do
		let(:user) {FactoryGirl.create(:user)}
		before {visit user_path(user)}

		it {should have_content(user.name)}
		it {should have_title(user.name)}
	end
end
