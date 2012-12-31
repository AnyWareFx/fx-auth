require 'data_mapper'
require 'dm-timestamps'
require 'dm-types'
require 'uuidtools'


%w(

  errors
  pass_key
  role
  user_profile

).each do |model|

  require "#{File.dirname(__FILE__)}/#{model}"
end
