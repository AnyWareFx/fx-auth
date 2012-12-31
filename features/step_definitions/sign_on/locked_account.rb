Then /^I am locked out$/ do
  @user.status.should == :locked
end