require_relative './ext/string'

# Graphql Expression
class GraphqlExpression
  class << self
    def auth(email, pass)
      %[user_auth(email: "#{email}", password: "#{pass}") {basicToken email}]
    end

    def host
      'host { info { dayOffset hostName hostTime hourOffset }}'
    end

    def user(email)
      email ? %[user(email: "#{email}") { id uuid balance email name }] : ''
    end

    def base(email)
      "{ #{host} #{user(email)} }"
    end
  end
end

GX = GraphqlExpression
