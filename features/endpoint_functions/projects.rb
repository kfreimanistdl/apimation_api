require 'rest-client'
require 'test-unit'

def create_new_project()
  project_payload = { name: 'project ' + Time.now.to_s,
                      type: 'basic' }.to_json

  response = post('http://apimation.com/projects',
                  headers: { 'Content-Type' => 'application/json' },
                  cookies: @test_user.session_cookie,
                  payload: project_payload)

  assert_equal(200, response.code, "Couldn't create new project! Response : #{response}")
  response_hash = JSON.parse(response)
  project = Project.new(response_hash['id'], response_hash['name'])
  assert_equal(project.project_name, response_hash['name'], "Incorrect project!")
  project
end

def select_new_project(project)
  #Delete active session
  response_delete = delete('http://apimation.com/environments/active',
                           headers: {},
                           cookies: @test_user.session_cookie)
  assert_equal(204, response_delete.code, "Can't delete active session! Response : #{response_delete}")

  #Select newly created project
  response_new_project = put('http://apimation.com/projects/active/' + project.project_id,
                             headers: {},
                             cookies: @test_user.session_cookie)
  assert_equal(204, response_new_project.code, "Can't delete active session! Response : #{response_new_project}")
end

def select_existing_project
  response_find_existing_project = get('http://apimation.com/projects',
                                       headers: {},
                                       cookies: @test_user.session_cookie)
  assert_equal(200, response_find_existing_project.code, "Can't retreive project list! Response : #{response_find_existing_project}")
  response_hash = JSON.parse(response_find_existing_project)

  response_select_existing_project = put('http://apimation.com/projects/active/' + response_hash[5]['id'],
                                         headers: {},
                                         cookies: @test_user.session_cookie)
  assert_equal(204, response_select_existing_project.code, "Existing project can't be selected! Response : #{response_select_existing_project}")
end