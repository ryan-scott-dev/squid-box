require 'spec_helper'

describe User do

  let (:attributes) { attributes = FactoryGirl.build(:user).attributes }

  context "Validation" do

    it "should be valid" do
      user = User.new(attributes)
      user.should be_valid
    end

  end

end
