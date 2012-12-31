
When /^I sign off$/ do
  @user.sign_off
end


Then /^I am offline$/ do
  @user.status.should == :offline
end

