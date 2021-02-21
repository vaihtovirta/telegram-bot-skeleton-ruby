class MessageParser
  def initialize(message:)
    @message = message
  end

  def command
    Client::COMMANDS.keys.find { |command| command == parsed_message&.first&.to_sym } || :help
  end

  def params
    parsed_message&.drop(1) || []
  end

  private

  def can_parse?
    !@message.text&.empty? && message_starts_with_slash?
  end

  def message_starts_with_slash?
    @message.text.start_with?("/")
  end

  def parsed_message
    @parsed_message ||= begin
      return unless can_parse?

      @message.text[1..-1].split(" ")
    end
  end
end
