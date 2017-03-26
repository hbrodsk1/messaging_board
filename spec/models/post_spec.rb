require 'rails_helper'

RSpec.describe Post, type: :model do
  
  it "has a valid factory" do
  	expect(FactoryGirl.create(:post)).to be_valid
  end

  context "associations" do
  	it { is_expected.to belong_to(:user) }
  end

  context "validations" do
  	it { is_expected.to validate_presence_of(:title) }
  	it { is_expected.to validate_presence_of(:body) }
  	it { is_expected.to validate_presence_of(:author) }
  	it { is_expected.to validate_presence_of(:user_id) }
  end
end
