include ApplicationHelper

def valid_signin(user)
  fill_in "Eメール",    with: user.email
  fill_in "パスワード", with: user.password
  click_button "Login"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

def sign_in(user, options={})
  if options[:no_capybara]
    # Capybaraを使用していない場合にもサインインする。
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit root_path
    fill_in "Eメール",    with: user.email
    fill_in "パスワード", with: user.password
    click_button "Login"
  end
end