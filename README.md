# Rupis

Rupis is a Ruby Language server, powered with Rust.

> **Warning**
> This project is in early development stage, and is not ready for production use.

## Installation

    $ gem install rupis

## Usage

TODO

## Goals

The higher the order, the higher the priority.

- Fast

- [ ] Syntax Check
  - [ ] [syntax_suggest](https://github.com/ruby/syntax_suggest) integration
- [ ] Type Check and completion
  - [ ] [rbs](https://github.com/ruby/rbs)
  - [ ] `as` operator (maybe comment?)
  - [ ] `ts-expect-error` like comment
  - [ ] [YARD](https://yardoc.org)
  - [ ] Type inference from untyped library
- [ ] Rails integration

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sevenc-nanashi/rupis. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/sevenc-nanashi/rupis/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rupis project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/sevenc-nanashi/rupis/blob/main/CODE_OF_CONDUCT.md).
