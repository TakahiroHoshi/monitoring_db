require 'spec_helper'

describe Company do
	before do
		#@company = Company.new(name: "Recruit", description: "This is a great company", founded_date: 1.years.ago, closed_date: 1.days.ago, stage: "Seed Round")
		@company = FactoryGirl.create(:company)
	end

	subject {@company}

	it {should respond_to(:name)}
	it {should respond_to(:description)}
	it {should respond_to(:founded_date)}
	it {should respond_to(:closed_date)}
	it {should respond_to(:stage)}
	it {should be_valid}
	it {should respond_to(:people)}

	describe "when name is not present" do
		before {@company.name = nil}
		it {should_not be_valid}
	end

	describe "when name is more than 200 characters" do
		before {@company.name = "a" * 201}
		it {should_not be_valid}
	end

#	describe "people associations" do
#		before {@company.save}
#		let!(:person) do
#			FactoryGirl.create(:person, company: @company)
#		end
#
#		it "should have person"
#			expect(@company.people.to_a).to eq person
#		end

end
