require 'spec_helper'

describe 'Index Page' do

	specify 'has email field' do
		visit root_path
		expect(page).to have_form(labe: email)
	end

	specify 'has password field' do
	end

	specify 'has login button' do
	end

end
