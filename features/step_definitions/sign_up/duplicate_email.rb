When /^I try to sign up with a duplicate email$/ do
  email = FactoryGirl.generate :email

  begin
    @user = AuthFx::UserProfile.sign_up email, "password"
    @user = AuthFx::UserProfile.sign_up email, "password"
  rescue => e
    puts e.message
  end
end


Then /^I receive a duplicate email error$/ do
  received = JSON.parse({:errors => @user.errors.to_h}.to_json)
  expected = JSON.parse({:error => "We already have that email."}.to_json)
  received.should == expected
end