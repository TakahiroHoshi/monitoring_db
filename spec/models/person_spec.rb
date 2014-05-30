require 'spec_helper'

describe Person do
	before do
		@person = Person.new(name: "Jane Qoo", position: "CEO")
	end

	subject {@person}

	it {should respond_to(:name)}
	it {should respond_to(:position)}
	it {should be_valid}

	describe "when name is not present" do
		before {@person.name = nil}
		it {should_not be_valid}
	end

	describe "when name position not present" do
		before {@person.position = nil}
		it {should_not be_valid}
	end

end
