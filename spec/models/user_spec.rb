require 'rails_helper'

RSpec.describe User, type: :model do

	it "has a valid factory" do
		expect(FactoryGirl.create(:user)).to be_valid
	end

	#context 'associations' do
	#	it { is_expected.to have_many(:posts) }
	#	it { is_expected.to have_many(:comments) }
	#end

	context 'validations' do
		it { is_expected.to validate_presence_of(:first_name) }
		it { is_expected.to validate_presence_of(:last_name) }
		it { is_expected.to validate_presence_of(:email) }
		it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
		it { is_expected.to validate_presence_of(:password) }

		it "is invalid with no first name" do
			expect(FactoryGirl.build(:user, first_name: nil)).to be_invalid
		end

		it "is invalid with no last name" do
			expect(FactoryGirl.build(:user, last_name: nil)).to be_invalid
		end

		it "is invalid with no email" do
			expect(FactoryGirl.build(:user, email: nil)).to be_invalid
		end

		it "is invalid with no password" do
			expect(FactoryGirl.build(:user, password: nil)).to be_invalid
		end

		it "validates uniqueness of email" do
			expect(FactoryGirl.create(:user, email: "user@benkinney.com")).to be_valid
			expect(FactoryGirl.build(:user, email: "user@benkinney.com")).to be_invalid
		end
	end	
end