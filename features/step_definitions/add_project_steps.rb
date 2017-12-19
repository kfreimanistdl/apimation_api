When(/^I create new project$/) do
  @project = create_new_project
end

When(/^I select newly created project$/) do
  select_new_project(@project)
end

When(/^I add new environment with name "([^"]*)"$/) do |environment|
  add_new_environment_with_name(@project, environment)
end

When(/^I add 2 global variable for each environment$/) do
  select_environment_and_add_global_variables(@project)
end

When(/^I delete all environments$/) do
  delete_all_environments(@project)
end