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

    it "the path should be a uri" do
      repository.path = "not a uri"
      repository.should_not be_valid
    end
  end

  describe "uri? method" do
    it "should return true when passed a uri" do
      Repository.uri?("http://google.com").should be_true
    end

    it "should be valid when using http" do
      Repository.uri?("http://google.com").should be_true
    end

    it "should be valid when using https" do
      Repository.uri?("https://google.com").should be_true
    end

    it "should be valid when using git" do
      Repository.uri?("git://google.com").should be_true
    end

    it "should be invalid when blank" do
      Repository.uri?("").should be_false
    end

    it "should be invalid when not a uri" do
      Repository.uri?("stuff").should be_false
    end
  end
end
