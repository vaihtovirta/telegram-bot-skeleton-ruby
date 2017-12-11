# Botup

**Botup** is command-line tool that generates basic skeleton for telegram bot.

## Installation

Just run this in your terminal:

    $ gem install botup

## Usage

Bootstrap new telegram bot was never so simple!

    $ botup my_super_bot # Provide bot name in snake_case
    $ cd my_super_bot && bundle install # Install dependencies

## What's in the bot?

    .
    |____bin
    | |____my_super_bot             # Executable for starting your bot client
    |____Gemfile
    |____lib
    | |____my_super_bot
    | | |____client.rb              # Telegram client which listens to incomming messages
    | | |____commands_keeper.rb     # Stores all available commands (includes test command by deault);
    | | |____commands_manager.rb    # Routes command to the appropriate one from commands_keeper.rb
    | | |____message_parser.rb      # Parses sent message to command and params
    | |____my_super_bot.rb

## How to use your bot
- Obtain bot api key by @BotFather and put it in *.env* file.
- Add desired methods to **lib/YOUR_BOT_NAME/commands_keeper.rb**. For example, to implement command */today_schedule* just create appropriate method:

    ```ruby
    def friday
      Time.now.friday? ? "Hooray it's friday" : "It's always Friday somewhere."
    end
    ```
- Start bot by running executable:

    ```$ my_super_bot/bin/my_super_bot```
- Try it out by sending /friday command(or some other command that you have already implemented)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vaihtovirta/botup. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Credits

Originally was inspired(and partially borrowed) by [telegram_meetup_bot](https://github.com/mendab1e/telegram_meetup_bot).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

