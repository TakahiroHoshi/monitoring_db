require 'spec_helper'

describe "Authentication" do

	subject {page}

	describe "signing page" do
		before {visit root_path}

		it {should have_content('RJB Monitoring DB')}
		it {should have_title('Monitoring DB | Welcome back')}

	end

	describe 'signin' do
		before {visit root_path}

		describe "with invalid information" do
			before {click_button "Login"}

			it {should have_title('Monitoring DB | Welcome back')}
			it {should have_selector('div.alert.alert-error', text: 'Invalid')}

			describe "after visiting another page" do
				before {visit root_path}
				it {should_not have_selector('div.alert.alert-error')}
			end
		end

		describe "with valid information" do
			let(:user) {FactoryGirl.create(:user)}
			before do
				fill_in "Eメール", with: user.email.upcase
				fill_in "パスワード", with: user.password
				click_button "Login"
			end

			it {should have_title(user.name)}
			it {should have_link('Logout', href: signout_path)}
			it {should have_link('Show Profile', href: user_path(user))}
			it {should have_link('Update Profile', href: edit_user_path(user))}
			it {should_not have_link('Login', href: root_path)}
		
			describe "followed by signout" do
				before {click_link "Logout"}
				it {should have_link('Sign up')}
			end
		end
	end
end
