require_relative "../lib/exchange"

Exchange.load_rails

require_relative "./app"

run Sinatra::Application
