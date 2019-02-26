require_relative './graphql_expression'

# Graphql Query
class GraphqlQuery
  class << self
    def base(email)
      Client.new(TS).query(GX.base(email))
    end

    def user(email)
      Client.new(TS).query(GX.user(email))
    end

    def user_auth(mail, pass)
      Client.new(TS).query(GX.auth(mail, pass).paren_wrap)
    end

  end
end

GQ = GraphqlQuery
