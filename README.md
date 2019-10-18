# the-hangman-game

This is a hangman CLI game. This game's secret keeper (computer) makes an API request for the word that will be guessed. This word is then displayed using `_` for each letter in the word. The guesser (user) can guess one letter at a time until they either hit 6 incorrect guesses or have guessed the word correctly. The game also keeps track of the guesser's correctly guessed words and returns it to them once they decide to quit. 

## Installation

Clone this repository `$ git clone git@github.com:torianne02/hangman-cli.git`

Move into the project directory by running `$ cd hangman-cli`

## Usage

Run the following:
```
$ bundle install
$ ruby bin/hangman
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/torianne02/hangman-cli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DayBooks project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/torianne02/hangman-cli/blob/master/CODE_OF_CONDUCT.md).
