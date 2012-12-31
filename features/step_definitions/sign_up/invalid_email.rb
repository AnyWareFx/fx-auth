
When /^I try to sign up with an invalid email address$/ do
  @user = AuthFx::UserProfile.sign_up "bad.email.com", "password"
end


Then /^I receive an invalid email error$/ do
  received = JSON.parse({:errors => @user.errors.to_h}.to_json)
  expected = JSON.parse({:errors => {:email => ["Doesn't look like an email address to me ..."]}}.to_json)
  received.should == expected
end