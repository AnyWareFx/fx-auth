module AuthFx

  class UserError < StandardError
  end


  class MissingUserError < UserError
    def initialize
      super 'We can''t find a user with that ID.' # TODO localize
    end
  end


  class DuplicateUserError < UserError
    def initialize
      super 'We already have that email.' # TODO localize
    end
  end


  class InvalidUserError < UserError
    def initialize
      super 'The email or pass phrase you provided doesn''t match our records.' # TODO localize
    end
  end


  class LockedUserError < UserError
    def initialize locked_until
      super 'Your account is locked. You can try to sign on again in 30 minutes.' # TODO localize
      @locked_until = locked_until # TODO display time in message?
    end
  end

end
