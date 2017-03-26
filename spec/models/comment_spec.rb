require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  it "has a valid factory" do
  	expect(FactoryGirl.create(:comment)).to be_valid
  end

  context "associations" do
  	it { is_expected.to belong_to(:user) }
  	it { is_expected.to belong_to(:post) }
  end

  context "validations" do
  	it { is_expected.to validate_presence_of(:body) }
  	it { is_expected.to validate_presence_of(:author) }
  	it { is_expected.to validate_presence_of(:user_id) }
  	it { is_expected.to validate_presence_of(:post_id) }
  end
end
