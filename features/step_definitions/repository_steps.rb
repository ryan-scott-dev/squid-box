Given /^I am on the new repository page$/ do
  visit new_repository_path
end

When /^I enter valid repository details$/ do
  fill_in('Name', :with => "test")
  fill_in('Path', :with => "test")
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