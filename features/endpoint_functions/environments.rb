require 'rest-client'
require 'test-unit'

def add_new_environment_with_name(project ,name)
  environment_payload = { name: name }.to_json

  response = post('http://apimation.com/environments',
                  headers: { 'Content-Type' => 'application/json' },
                  cookies: @test_user.session_cookie,
                  payload: environment_payload)

  assert_equal(200, response.code, "Couldn't create new environment! Response : #{response}")
  response_hash = JSON.parse(response)
  assert_equal(name, response_hash['name'], "Incorrect environment!")
  environment = Environment.new(response_hash['id'], response_hash['name'])
  project.add_environment(environment)
  environment
end

def select_environment_and_add_global_variables(project)
  global_variable_payload = { global_vars: [{ value: 'TEST1', key: 'one' },
                                            { value: 'TEST2', key: 'two' }] }.to_json

  project.environments.each do |env|
    response_put = put('http://apimation.com/environments/active/' + env.environment_id,
                       headers: {},
                       cookies: @test_user.session_cookie)
    assert_equal(204, response_put.code, "Can't select Environment! Response : #{response_put}")

    response_get = get('http://apimation.com/environments/' + env.environment_id,
                       headers: {},
                       cookies: @test_user.session_cookie)
    assert_equal(200, response_get.code, "Can't get environment details! Response : #{response_get}")
    response_get_hash = JSON.parse(response_get)
    assert_equal(env.environment_name, response_get_hash['name'], "Incorrect environment! Response : #{response_get}")
    assert_equal(env.environment_id, response_get_hash['id'], "Incorrect environment! Response : #{response_get}")

    response_put_global_variables = put('http://apimation.com/environments/' + env.environment_id,
                                        headers: { 'Content-Type' => 'application/json' },
                                        cookies: @test_user.session_cookie,
                                        payload: global_variable_payload)
    assert_equal(204, response_put_global_variables.code, "Global variables are not added! Response : #{response_put_global_variables}")
  end
end

def delete_all_environments(project)
  project.environments.each do |env|
    response_delete = delete('http://apimation.com/environments/' + env.environment_id,
                             headers: {},
                             cookies: @test_user.session_cookie)
    assert_equal(204, response_delete.code, "Can't delete environment! Response : #{response_delete}")
  end
end

