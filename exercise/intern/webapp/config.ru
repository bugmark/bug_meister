require_relative "../../Lib/dotenv"
require_relative "../../Lib/trial_settings"
require_relative "../../Lib/graphql_client"

require_relative "./app"

run Sinatra::Application
