require 'graphlient'
require 'base64'

# GraphQL client class
class GraphqlClient

  attr_reader :settings, :usermail, :password

  def initialize(settings, usermail = 'admin@bugmark.net', password = 'bugmark')
    @settings = settings
    @usermail = usermail
    @password = password
  end

  # Return GraphQL Schema
  def schema
    client.schema
  end

  # Reset schema cache
  def reset_schema_cache
    client.schema.dump!
  end

  # Post a query expression
  def query(query_string)
    puts '@' * 60
    puts query_string
    puts '@' * 60
    client.query("query #{query_string}")
  end

  # Post a mutation expression
  def mutation(mutation_string)
    client.query("mutation #{mutation_string}")
  end

  private

  def client
    user = "#{usermail}:#{password}"
    cyph = Base64.encode64(user).chomp
    url  = "#{settings.exchange_url}/graphql"
    opts = {
      headers: {"Authorization": "Basic #{cyph}"},
      schema_path: '/tmp/bmx_testbench_schema.json'
    }
    @client ||= Graphlient::Client.new(url, opts)
  end
end

Client = GraphqlClient
