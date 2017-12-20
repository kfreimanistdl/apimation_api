Before() do
  puts "Before hook. This will work before every test case!"
  @test_user = User.new('rest_api_automation6@mailinator.com', 'Password!@£')
end

After() do
  puts "Happens after a test scenario"
end