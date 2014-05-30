require 'spec_helper'

describe Company do
	before do
		@company = Company.new(name: "Recruit", description: "This is a great company", founded_date: 1.years.ago, closed_date: 1.days.ago, stage: "Seed Round")
	end

	subject {@company}

	it {should respond_to(:name)}
	it {should respond_to(:description)}
	it {should respond_to(:founded_date)}
	it {should respond_to(:closed_date)}
	it {should respond_to(:stage)}
	it {should be_valid}

	describe "when name is not present" do
		before {@company.name = nil}
		it {should_not be_valid}
	end

end
