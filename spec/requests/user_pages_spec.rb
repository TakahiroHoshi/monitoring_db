require 'spec_helper'

describe "User Pages" do

	subject {page}

	describe "index" do

		let(:user) {FactoryGirl.create(:user)}

		before do
			sign_in user
			visit users_path
		end

		it {should have_title('All Users')}
		it {should have_content('All Users')}

		describe "pagination" do
			before(:all) {30.times {FactoryGirl.create(:user)}}
			after(:all) {User.delete_all}

			it {should have_selector('div.pagination')}

			it "should list each user" do
				User.paginate(page: 1).each do |user|
					expect(page).to have_selector('li', text: user.name)
				end
			end
		end

		describe "delete links" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit users_path
      end

      it { should have_link('Delete', href: user_path(User.first)) }
      it "should be able to delete another user" do
        expect do
          click_link('Delete', match: :first)
        end.to change(User, :count).by(-1)
      end
      it { should_not have_link('Delete', href: user_path(admin)) }
    end

	end

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

			describe "after saving the user" do
				before {click_button submit}
				let(:user){User.find_by(email: 'tom.york@aef.aef')}

				it {should have_link('Logout')}
				it {should have_title(user.name)}
				it {should have_selector('div.alert.alert-success', text: 'Welcome')}
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

	describe "edit" do
		let(:user) {FactoryGirl.create(:user)}
		before do
			sign_in user
			visit edit_user_path(user)
		end

		describe "page" do
			it {should have_content("Update Profile")}
			it {should have_title("Update Profile")}
		end

		describe "with invalid information" do
			before {click_button "Update"}

			it {should have_content('エラー')}
		end

		describe "with valid information" do
			let(:new_name) {"New Name"}
			let(:new_email) {"new@example.com"}
			let(:new_id_num) {"01012223"}
			let(:new_organization) {"経営企画部"}
			before do
				fill_in "名前", with: new_name
				fill_in "Eメール", with: new_email
				fill_in "社員番号", with: new_id_num
				fill_in "所属組織", with: new_organization
				fill_in "パスワード", with: user.password
				fill_in "パスワード確認", with: user.password
				click_button "Update"
			end

			it {should have_title(new_name)}
			it {should have_selector('div.alert.alert-success')}
			it {should have_link('Logout', href: signout_path)}
			specify {expect(user.reload.name).to eq new_name}
			specify {expect(user.reload.email).to eq new_email}
			specify {expect(user.reload.id_num).to eq new_id_num}
			specify {expect(user.reload.organization).to eq new_organization}

		end
	end
end
