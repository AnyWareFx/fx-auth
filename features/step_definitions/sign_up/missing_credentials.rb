
When /^I try to sign up with a missing email address$/ do
  @user = AuthFx::UserProfile.sign_up '', 'password'
end


Then /^I receive an missing email error$/ do
  received = JSON.parse({:errors => @user.errors.to_h}.to_json)
  expected = JSON.parse({:errors => {:email => ['We need your email address.']}}.to_json)
  received.should == expected
end


When /^I try to sign up with a missing password$/ do
  email = FactoryGirl.generate :email
  @user = AuthFx::UserProfile.sign_up email, ''
end


Then /^I receive a missing password error$/ do
  received = JSON.parse({:errors => @user.errors.to_h}.to_json)
  expected = JSON.parse({:errors => {:pass_phrase => ['Pass phrase must be between 5 and 50 characters long']}}.to_json)
  received.should == expected
end