module AuthFx

  class PassKey
    include DataMapper::Resource

    belongs_to :user_profile


    property :id, Serial
    property :created_at, DateTime
    property :updated_at, DateTime

    property :token, String, :unique => true
    property :expires, Time, :required => true


    before :create do
      self.token   = UUIDTools::UUID.random_create.to_s
      self.expires = Time.now + 30 * 60 # expires 30 minutes from now
    end


    def authenticate? token
      self.token == token and !expired?
    end


    # TODO Regenerate for each request?
    def regenerate
      self.token = UUIDTools::UUID.random_create.to_s
      reset_timer
      self.token
    end


    def expired?
      Time.now > self.expires
    end


    def reset_timer
      self.expires = Time.now + 30 * 60 # the user has another 30 minutes - TODO make configurable
      save
      self.expires
    end

  end

end
