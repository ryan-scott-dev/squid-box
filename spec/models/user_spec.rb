require 'spec_helper'

describe User do

  let (:user) { user = attributes = FactoryGirl.build(:user) }
  let (:attributes) { user.attributes }

  context "Validation" do

    it "should be valid" do
      user.should be_valid
    end

    it "should not be allowed to mass assign attributes" do
      new_user = User.new(attributes)
      new_user.should_not be_valid
    end

  end

end
