When(/^I login apimation.com as a regular user$/) do
  login_positive
end

Then(/^I check if I am logged in and I can access my personal information$/) do
  check_personal_info
end

When(/^I try to login apimation.com with a wrong password$/) do
  login_wrong_password
end

Then(/^I check if I am not logged in and I cannot access my personal data$/) do
  check_user_not_logged
end