require 'spec_helper'

describe "StaticPages" do
  #describe "GET /static_pages" do
  #  it "works! (now write some real specs)" do
      #get static_pages_index_path
      #response.status.should be(200)
    #end
  #end

  describe "Home Page" do

  	it "should have the content 'Monitoring DB'" do
  		visit root_path
  		expect(page).to have_content('Monitoring DB')
  	end
  end

  describe "Signup Page" do
    #Submitしたらモデルにユーザーオブジェクトが追加される


  end



end
