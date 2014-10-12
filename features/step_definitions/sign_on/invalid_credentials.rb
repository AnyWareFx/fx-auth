
When /^I try to sign on with invalid credentials$/ do
  begin
    @user.sign_on 'bad@email.com', 'bad-password'
  rescue => e
    puts e.message
  end
end
