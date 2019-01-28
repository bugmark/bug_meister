require 'graphlient'
require 'base64'

class BmgBase
  class GraphqlClient

    attr_reader :config

    def initialize(config)
      @config = config
    end

    def schema
      client.schema
    end

    def query(query_string)
      client.query("query #{query_string}")
    end

    def mutation(mutation_string)
      client.query("mutation #{mutation_string}")
    end

    private

    def client
      user = "#{config["usermail"]}:#{config["password"]}"
      cyph = Base64.encode64(user).chomp
      url  = "#{config["scheme"]}://#{config["host"]}/graphql"
      opts = { headers: {"Authorization": "Basic #{cyph}"} }
      @cclient ||= Graphlient::Client.new(url, opts)
    end
  end
end
