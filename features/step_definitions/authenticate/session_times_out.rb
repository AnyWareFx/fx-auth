
When /^My session times out$/ do
  @user.pass_key.expires_at = Time.now - 30 * 60 # expired 30 minutes ago
end