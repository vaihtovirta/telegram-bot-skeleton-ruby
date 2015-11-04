require 'thor'

require 'botup/version'
require 'botup/processor'

module Botup
  class Generator < Thor
    desc 'generates bot_name_in_snake_case', 'generate bot by name'
    def self.generate(name)
      Processor.new(name).call
    end
  end
end
