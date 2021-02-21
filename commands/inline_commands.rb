class InlineCommands
  def initialize(message:)
    @message = message
  end

  def results
    [
      Telegram::Bot::Types::InlineQueryResultArticle.new(
        id: @message.object_id,
        title: "Code block",
        input_message_content: Telegram::Bot::Types::InputTextMessageContent.new(
          **Client::PARSE_MODE,
          message_text: <<~CODE
            ```
            #{@message.query}
            ```
          CODE
        )
      )
    ]
  end
end
