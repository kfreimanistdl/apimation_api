Before() do
  puts "Before hook. This will work before every test case!"
  @test_user = User.new('rest-api-automation@mailinator.com', 'Password!@£')
end

After() do
  puts "Happens after a test scenario"
end