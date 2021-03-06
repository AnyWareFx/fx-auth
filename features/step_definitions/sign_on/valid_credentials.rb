
Given /^I have a User Profile$/ do
  @user = FactoryGirl.create :user_profile
  @user.save # TODO Determine why this is necessary
end


When /^I sign on with valid credentials$/ do
  @user.sign_on @user.email, 'password'
end


Then /^I am online$/ do
  @user.status.should == :online
end
