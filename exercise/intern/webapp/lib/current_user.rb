# current_user class
class CurrentUser
  attr_reader :email, :data

  def initialize(email)
    expr   = GX.user_expression(email).paren_wrap
    @email = email
    @data  = Client.new(TS).query(expr).data.user
  end

  def name
    data.name
  end

  def balance
    data.balance
  end

  def id
    data.id
  end

  def uuid
    data.uuid
  end

  def token_available
    'TBD'
  end
end
