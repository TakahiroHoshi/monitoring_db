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
			before {sign_in user}

			it {should have_title(user.name)}
			it {should_not have_link('Users', href: users_path)}
			it {should have_link('Logout', href: signout_path)}
			it {should have_link('Show Profile', href: user_path(user))}
			it {should have_link('Update Profile', href: edit_user_path(user))}
			it {should_not have_link('Login', href: root_path)}
		
			describe "followed by signout" do
				before {click_link "Logout"}
				it {should have_link('Sign up')}
			end
		
			describe "in the Users controller" do

				describe "visiting the user index" do
					before {visit users_path}
					it {should_not have_title('All Users')}
				end
			end

		end
	end

	describe "authorization" do

		describe "as non-admin user" do
			let(:user) {FactoryGirl.create(:user)}
			let(:non_admin) {FactoryGirl.create(:user)}

			before {sign_in non_admin, no_capybara: true}

			describe "submitting a DELETE request to the Users#destroy action " do
				before {delete user_path(user)}
				specify {expect(response).to redirect_to(root_path)}
			end
		end

		describe "for non-signed-in users" do
			let(:user) {FactoryGirl.create(:user)}

			describe "when attempting to visit a protected page" do
				before do
					visit edit_user_path(user)
					fill_in "Eメール", with: user.email
					fill_in "パスワード", with: user.password
					click_button "Login"
				end

				describe "after signing in" do

					it "should render the desired protected page" do
						expect(page).to have_title('Update Profile')
					end
				end
			end

			describe "in the Users controller," do

				describe "visiting the edit page" do
					before {visit edit_user_path(user)}
					it {should have_content('Please sign in')}
				end

				describe "submitting to the update action" do
					before {patch user_path(user)}
					specify {expect(response).to redirect_to(root_path)}
				end

				describe "visiting the user index" do
					before {visit users_path}

					it {should have_title('Welcome back')}
				end
			end
		end

		describe "as wrong user" do
			let(:user) {FactoryGirl.create(:user)}
			let(:wrong_user) {FactoryGirl.create(:user, email: "wrong@example.com")}
			before {sign_in user, no_capybara: true}

			describe "submitting a GET request to the Users#edit action" do
				before {get edit_user_path(wrong_user)}
				it {should_not have_title("Update Profile")}
				specify {expect(response).to redirect_to(root_path)}
			end

			describe 	"submitting a PATCH request to the Users#update action" do
				before {patch user_path(wrong_user)}
				specify {expect(response).to redirect_to(root_path)}
			end
		end
	end
end
