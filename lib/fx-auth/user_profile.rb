module AuthFx

  class UserProfile
    include DataMapper::Resource

    has 1, :pass_key, :constraint => :destroy
    has n, :user_roles, :constraint => :destroy
    has n, :roles, :through => :user_roles

    property :id, Serial
    property :created_at, DateTime
    property :updated_at, DateTime

    property :email, String,
             :required => true,
             :unique   => true,
             :format   => :email_address,
             :messages => {
                 :presence  => "We need your email address.",
                 :is_unique => "We already have that email.",
                 :format    => "Doesn't look like an email address to me ..."
             }
    property :gravatar, String, :length => 255

    property :email_verification_code, String, :length => 36, :unique => true
    property :verification_code_sent_at, DateTime
    property :verification_code_expires_at, DateTime
    property :email_verified_at, DateTime

    property :pass_phrase, String, :length => 5..50
    property :pass_phrase_crypt, BCryptHash
    property :pass_phrase_expires_at, Time

    property :status, Enum[:online, :offline, :locked], :default => :offline
    property :sign_on_attempts, Integer, :default => 0
    property :locked_until, Time


    before :create do
      self.email_verification_code = UUIDTools::UUID.random_create.to_s
      user_role                    = Role.first :name => :user
      self.roles << user_role if user_role
    end


    after :valid? do
      self.gravatar = "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest self.email}"
      if self.pass_phrase != '*****'
        self.pass_phrase_crypt = self.pass_phrase
        self.pass_phrase       = '*****'
      end
    end


    def self.sign_up email, pass_phrase
      user = UserProfile.first :email => email
      raise DuplicateUserError if user

      user = UserProfile.new :email => email, :pass_phrase => pass_phrase
      if user.valid?
        user.status = :online
        user.save
      end
      user
    end


    def sign_on email, pass_phrase
      self.status = :offline if self.pass_key and self.pass_key.expired?
      self.status = :offline if self.status == :locked and self.lock_expired?

      if self.status == :online
        self.pass_key

      elsif self.status == :offline
        if self.email == email and self.pass_phrase_crypt == pass_phrase
          self.status = :online
          save
          self.pass_key

        else
          self.sign_on_attempts += 1
          save
          raise InvalidUserError unless self.sign_on_attempts >= 3 # TODO make configurable

          self.status = :locked
          save
          raise LockedUserError.new self.locked_until
        end

      else # :locked
        raise LockedUserError.new self.locked_until
      end
    end


    def sign_off
      self.status = :offline
      save
    end


    def status=(value)
      if value == :online
        self.locked_until     = Time.now - 30 * 60 # Unlocked 30 minutes ago - TODO make configurable
        self.sign_on_attempts = 0
        self.pass_key         = PassKey.new

      elsif value == :offline
        self.locked_until     = Time.now - 30 * 60 # Unlocked 30 minutes ago - TODO make configurable
        self.sign_on_attempts = 0
        self.pass_key.destroy if self.pass_key

      elsif value == :locked
        self.locked_until = Time.now + 30 * 60 # Lock for 30 minutes - TODO make configurable
        self.pass_key.destroy if self.pass_key
      end

      super
    end


    def status
      self.status = :offline if super == :online and
          self.pass_key and
          self.pass_key.expires_at and
          Time.now > self.pass_key.expires_at
      super
    end


    def authenticate? token
      authenticated = (self.status == :online and
          self.pass_key and
          self.pass_key.authenticate? token
      )
      self.pass_key.reset_timer if authenticated
      authenticated
    end


    def authorized? *roles
      roles.any? { |role| self.in_role? role }
    end


    def in_role? role
      found = self.roles.first :name => role
      !found.nil?
    end


    def verify_email? email, code
      self.email_verified = (self.email == email and self.email_verification_code == code)
      save
      self.email_verified
    end


    def lock_expired?
      Time.now > self.locked_until
    end

  end

end
