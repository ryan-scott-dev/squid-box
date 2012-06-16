Given /^I am on the new repository page$/ do
  visit new_repository_path
end

When /^I enter valid repository details$/ do
  fill_in('Name', :with => "test")
  fill_in('Path', :with => "git://github.com/mojombo/grit.git")
end

When /^I create the repository$/ do
  page.click_on("Create Repository")
end

Then /^I should see a repository created message$/ do
  page.should have_content("Repository Created")
end

When /^I enter invalid repository details$/ do
  #Don't enter in anything as this should be invalid
end

Then /^I should see an error message$/ do
  find("#error_messages").has_content?("errors")
end

When /^I should see a cloning repository message$/ do
  page.should have_content("Cloning Repository")
end

When /^I am on the show repository page for "([^"]*)"$/ do |name|
  repository = Repository.find_by_name name

  visit repository_path(repository)
end

Then /^I should see the repositories commits$/ do
  page.should have_content("Commits")

  page.all(".commit").should_not be_blank
end
