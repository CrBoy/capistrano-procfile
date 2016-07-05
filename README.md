# Capistrano::Procfile

This gem helps exporting [Procfile][https://devcenter.heroku.com/articles/procfile] to system init daemon (e.g. systemd, upstart) configurations.

Notice: This gem calls `foreman export` to do the things. Therefore the supported format by foreman should be supported as well. However I use only systemd, so others formats are not tested. PRs are welcome! :)

Currently we supports systemd only.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-procfile'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-procfile

## Usage

The following options are available. You can set these options in `config/deploy.rb`.

```
set :procfile_roles, %w(app)
set :procfile_use_sudo, false
set :procfile_options, {
	export_format: :systemd,
	export_path: "/etc/systemd/system",
	working_dir: release_path,
	log_dir: File.join(release_path, "log"),
	base_port: 5000,
	app_name: fetch(:application),
	user: nil,
	formation: "all=1"
}
```

Run `cap production procfile:export` to export on the target machine.

Host property is also available for options. Check the following example.

```
# config/deploy/production.rb

server 'production1', user: 'app', roles: %w{app}, procfile_options: { formation: "web=1,worker=1" }
server 'production2', user: 'app', roles: %w{app}, procfile_options: { formation: "worker=4" }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/capistrano-procfile.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

