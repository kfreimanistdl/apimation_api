require 'rest-client'
require 'test-unit'

def create_new_collection
  collection_payload = { name: 'collection ' + Time.now.to_s,
                         description: 'collection_description' }.to_json

  response = post('http://apimation.com/collections',
                  headers: { 'Content-Type' => 'application/json' },
                  cookies: @test_user.session_cookie,
                  payload: collection_payload)

  assert_equal(200, response.code, "Couldn't create new collection! Response : #{response}")
  response_hash = JSON.parse(response)
  collection = Collection.new(response_hash['id'], response_hash['name'])
  assert_equal(collection.collection_name, response_hash['name'], "Incorrect collection!")
  collection
end

def add_test_steps(collection)
  step_payload = { name: 'test_case' + Time.now.to_s,
                   description: '',
                   request: { method: 'POST',
                              url: 'https://apimation.com/login',
                              type: 'raw',
                              body: "{\"login\":\"rest_api_automation6@mailinator.com\",\"password\":\"Password!@£\"}",
                              binaryContent: { value: '',
                                               filename: '' },
                              urlEncParams: [{ name: '',
                                               value: '' }],
                              formData: [{ type: 'text',
                                           value: '',
                                           name: '',
                                           filename: '' }],
                              headers: [{ name: 'Content-Type',
                                          value: 'application/json' }],
                              greps: [],
                              auth: { type: 'noAuth',
                                      data: {} } },
                   paste: false,
                   collection_id: collection.collection_id }.to_json

  response = post('http://apimation.com/steps',
                  headers: { 'Content-Type' => 'application/json' },
                  cookies: @test_user.session_cookie,
                  payload: step_payload)
  assert_equal(200, response.code, "Couldn't add step! Response : #{response}")
end

def check_test_case_creation(collection)
  response = get('http://apimation.com/collections/' + collection.collection_id,
                 headers: { 'Content-Type' => 'application/json' },
                 cookies: @test_user.session_cookie)
  assert_equal(200, response.code, "Test not found! Response : #{response}")
end