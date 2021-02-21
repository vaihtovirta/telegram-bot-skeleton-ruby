class Client
  COMMANDS = {
    greeting: Greeting,
    help: Help,
    test: Test
  }.freeze
  PARSE_MODE = { parse_mode: "MarkdownV2" }.freeze

  def initialize(token, logger: Logger.new("/proc/1/fd/1"))
    @token = token
    @logger = logger
  end

  def start
    Telegram::Bot::Client.run(@token, logger: @logger) { |bot| listen_to_messages(bot) }
  end

  private

  def listen_to_messages(bot)
    bot.listen do |message|
      @logger.debug(message.inspect)

      case message
      when Telegram::Bot::Types::InlineQuery
        handle_inline_query(bot, message)
      when Telegram::Bot::Types::Message
        handle_message(bot, message)
      end
    rescue Telegram::Bot::Exceptions::ResponseError => e
      @logger.error(e)
      sleep 1
      retry
    end
  end

  def handle_inline_query(bot, message)
    return if message.query.empty?

    inline_commands = InlineCommands.new(message: message)

    bot.api.answer_inline_query(
      inline_query_id: message.id,
      results: inline_commands.results
    )
  end

  def handle_message(bot, message)
    MessageParser
      .new(message: message)
      .then { |parser| COMMANDS[parser.command].new(message: message, params: parser.params).call }
      .then { |response| response && bot.api.send_message(chat_id: message.chat.id, text: response, **PARSE_MODE) }
  end
end
