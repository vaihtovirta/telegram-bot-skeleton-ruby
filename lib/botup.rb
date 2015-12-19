require 'botup/version'
require 'botup/file_processor'

module Botup
  class Generator
    def self.generate(name)
      FileProcessor.new(name).call
    end
  end
end
