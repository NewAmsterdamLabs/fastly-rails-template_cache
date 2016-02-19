# TemplateCache extension to FastlyRails

From Fastly's Blog post [Surrogate Keys: Part 1](https://www.fastly.com/blog/surrogate-keys-part-1):
> Since you’re caching entire pages, just updating the header template isn’t enough. You’ll also need to purge all the pages that use this template. While you could purge every page on the site, there’s no reason to purge content that doesn’t use the header template.
>
> Surrogate keys to the rescue! You can add surrogate keys for each template on a page (e.g. /templates/pic/show, /templates/pic/header, /templates/pic/comment). During deployment, you can check which templates have changed and only purge pages with modified templates.

But how can we easily keep the list of templates rendered for each page?  We could do this manually, but that would be time consuming and error prone.  The TemplateCache extension to Fastly-Rails adds each rendered template to the `Surroage-Keys` header on each request.  A set of rake tasks are provided to keep track of the digests of each template in your application.  On each deploy, just run `$ rake fastly:template_cache:purge_stale` to purge all records that rely on modified templates.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fastly-rails-template_cache'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fastly-rails-template_cache

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/template_cache. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

