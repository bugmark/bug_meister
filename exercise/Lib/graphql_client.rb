require 'graphlient'
require 'base64'

class GraphqlClient

  attr_reader :settings, :usermail, :password

  def initialize(settings, usermail = "admin@bugmark.net", password = "bugmark")
    @settings = settings
    @usermail = usermail
    @password = password
  end

  def schema
    client.schema
  end

  def schema_reset
    client.schema.dump!
  end

  def query(query_string)
    client.query("query #{query_string}")
  end

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
      schema_path: "/tmp/bmx_testbench_schema.json"
    }
    @cclient ||= Graphlient::Client.new(url, opts)
  end
end

Client = GraphqlClient
