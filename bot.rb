require "bundler/setup"
require "telegram/bot"
require "logger"

$LOAD_PATH.unshift("#{Dir.pwd}/commands")
$LOAD_PATH.unshift("#{Dir.pwd}/lib")

require "command"
require "greeting"
require "help"
require "inline_commands"
require "test"

require "client"
require "message_parser"

Client.new(ENV["TELEGRAM_BOT_TOKEN"]).start
