require 'data_mapper'
require 'uuidtools'


%w(

  errors
  pass_key
  role
  user_profile

).each do |model|

  require "#{File.dirname(__FILE__)}/#{model}"
end
