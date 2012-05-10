require 'spec_helper'

describe Repository do

  describe "Creating a repository" do
    before(:each) do
      @repository = Repository.new
      @repository.name = "test-repo"
      @repository.path = "git://github.com/mojombo/grit.git"
    end

    after(:each) do
      if File.directory? @repository.relative_local_path
        FileUtils.rm_rf(@repository.relative_local_path)
      end
    end

    it "should be able to create a repository" do
      @repository.should_not be_nil
    end

    it "should not create a local copy" do
      File.directory?(@repository.relative_local_path).should be_false
    end

    it "should be able create a local copy" do
      @repository.create_new_repository

      File.directory?(@repository.relative_local_path).should be_true
    end
  end

end