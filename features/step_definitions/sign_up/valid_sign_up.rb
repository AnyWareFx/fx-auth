
Given /^I sign up with valid credentials$/ do
  email = FactoryGirl.generate :email
  @user = AuthFx::UserProfile.sign_up email, 'password'
end
