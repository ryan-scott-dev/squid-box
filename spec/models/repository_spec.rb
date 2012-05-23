require 'spec_helper'

describe Repository do
  let(:repository) { FactoryGirl.create(:repository) }

  describe "Validation" do

    it "should be able to be valid" do
      repository.should be_valid
    end

    it "should be invalid if it doesn't have a name" do
      repository.name = ""
      repository.should_not be_valid
    end

    it "should be invalid if it doesn't have a path" do
      repository.path = ""
      repository.should_not be_valid
    end

  end


end
