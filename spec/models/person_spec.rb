require 'spec_helper'

describe Person do
	#let(:company) {FactoryGirl.create(:company)}
	before do
		#@company = Company.new(id: 1, name: "Recruit", description: "This is a great company", founded_date: 1.years.ago, closed_date: 1.days.ago, stage: "Seed Round")
		company = FactoryGirl.create(:company)
		@person = company.people.build(id: 1, name: "Jane Qoo", position: "CEO", company_id: 1)
	end

	subject {@person}

	it {should respond_to(:name)}
	it {should respond_to(:position)}
	it {should be_valid}
	its(:company) {should eq @person.company}

	describe "when company_id is not present" do
		before {@person.company_id = nil}
		it {should_not be_valid}
	end

	describe "when name is not present" do
		before {@person.name = nil}
		it {should_not be_valid}
	end

	describe "when name position not present" do
		before {@person.position = nil}
		it {should_not be_valid}
	end

	describe "when name is longer than 100 characters" do
		before {@person.name = "a" * 101}
		it {should_not be_valid}
	end
	
	describe "when position is longer than 100 characters" do
		before {@person.position = "a" * 101}
		it {should_not be_valid}
	end
	
end
