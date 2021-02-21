class Help < Command
  def call
    <<~COMMANDS
      Available commands:
      #{Client::COMMANDS.keys.join("\n")}
    COMMANDS
  end
end
