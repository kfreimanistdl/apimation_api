require 'rest-client'
require 'test-unit'

def login_positive
  login_payload = { login: @test_user.email,
                    password: @test_user.password }.to_json

  response = RestClient::Request.execute(method: :post,
                                         url: 'https://www.apimation.com/login',
                                         headers: { 'Content-Type' => 'application/json' },
                                         cookies: {},
                                         payload: login_payload)
  # Check if 200 OK is received
  assert_equal(200, response.code, "Login Failed! Response : #{response}")

  response_hash = JSON.parse(response)

  assert_equal(@test_user.email, response_hash['email'], "Incorrect email")

  assert_not_equal(nil, response_hash['user_id'], 'User Id is empty')

  @test_user.set_session_cookie(response.cookies)
  @test_user.set_user_id(response_hash['user_id'])
end

def check_personal_info
  response_user = RestClient::Request.execute(method: :get,
                                              url: 'https://apimation.com/user',
                                              headers: {},
                                              cookies: @test_user.session_cookie)
  assert_equal(200, response_user.code, "Unable to login!")
  response_hash = JSON.parse(response_user)

  assert_equal(@test_user.email, response_hash['email'], "Incorrect email")
  assert_equal(@test_user.email, response_hash['login'], "Incorrect login")
  assert_equal(@test_user.user_id, response_hash['user_id'], "Incorrect user id")

  response_projects = RestClient::Request.execute(method: :get,
                                                  url: 'https://apimation.com/projects',
                                                  headers: {},
                                                  cookies: @test_user.session_cookie)

  response_hash = JSON.parse(response_projects)

  assert_equal('rest-api-workshop-with-Karbic', response_hash[0]['name'], "Incorrect project")
end

def login_wrong_password
  login_payload = { login: @test_user.email,
                    password: 'test123' }.to_json

  response = post('https://www.apimation.com/login',
                  headers: { 'Content-Type' => 'application/json' },
                  cookies: {},
                  payload: login_payload)

  # Check if 400 Bad Request is received
  assert_equal(400, response.code, "Login Failed! Response : #{response}")

  response_hash = JSON.parse(response)

  assert_equal('002', response_hash['error-code'], "Error code in response is not correct!")
  assert_equal('Username or password is not correct', response_hash['error-msg'], "Error message is not correct")

  @test_user.set_session_cookie(response.cookies)
end

def check_user_not_logged
  response = get('https://apimation.com/user',
                 headers: {},
                 cookies: @test_user.session_cookie)

  assert_equal(400, response.code, "Login Failed! Response : #{response}")
  response_hash = JSON.parse(response)

  assert_equal('001', response_hash['error-code'], "Error code in response is not correct!")
  assert_equal('No session', response_hash['error-msg'], "Error message is not correct")
end