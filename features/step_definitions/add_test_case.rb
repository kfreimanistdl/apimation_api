When(/^I select existing project$/) do
  select_existing_project
end

When(/^I create new request Collection$/) do
  @collection = create_new_collection
end

When(/^I add apimation login test steps$/) do
  add_test_steps(@collection)
end

When(/^test case is successfully created$/) do
  check_test_case_creation(@collection)
end

