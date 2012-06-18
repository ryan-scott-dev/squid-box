
When /^I log in with "([^"]*)" and "([^"]*)"$/ do |username, password|
  visit home_path
  fill_in "Login", :with => username
  fill_in "Password", :with => password

  click_on "Login"
end

Then /^I should see a log in success message$/ do
  find("#flash").find(".notice").should have_content "Log in successful"
end

Then /^I should see a log in failed message$/ do
  find("#flash").find(".error").should have_content "Invalid Login"
end