require_relative "../../Lib/exercise_env"
require_relative "../../Lib/trial_settings"
require_relative "../../Lib/graphql_client"

require_relative "./app"

run Sinatra::Application
