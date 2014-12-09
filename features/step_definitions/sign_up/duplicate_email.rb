When /^I try to sign up with a duplicate email$/ do
  email = FactoryGirl.generate :email

  begin
    @user = AuthFx::UserProfile.sign_up email, 'password'
    @user = AuthFx::UserProfile.sign_up email, 'password'
  rescue => e
    @message = e.message
  end
end


Then /^I receive a duplicate email error$/ do
  @message.should == 'We already have that email.'
end