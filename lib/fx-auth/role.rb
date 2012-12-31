module AuthFx

  class Role
    include DataMapper::Resource

    has n, :user_roles, :constraint => :destroy
    has n, :user_profiles, :through => :user_roles

    property :id, Serial
    property :created_at, DateTime
    property :updated_at, DateTime

    property :name, String, :required => true, :unique => true
    property :description, Text
  end


  class UserRole
    include DataMapper::Resource

    belongs_to :user_profile
    belongs_to :role

    property :id, Serial
    property :created_at, DateTime
    property :updated_at, DateTime
  end

end
