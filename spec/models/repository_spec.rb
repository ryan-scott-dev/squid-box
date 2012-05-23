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

    it "should be invalid if the path isn't a uri" do
      repository.path = "not a uri"
      repository.should_not be_valid
    end

    it "should be invalid if the path isn't a git repo" do
      repository.path = "git://github.com/mojombo/dirt.git"
      repository.should_not be_valid
    end
  end

  describe "is_git_repo? method" do
    it "should return true when passed a valid git repo" do
      Repository.is_git_repo?("git://github.com/mojombo/grit.git").should be_true
    end

    it "should return false when passed an invalid git repo" do
      Repository.is_git_repo?("http://google.com").should be_false
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
