## Installation

Add this line to your application's Gemfile:

```ruby
gem 'usda_fdc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install usda_fdc

## Usage

### Create API client object (visit https://fdc.nal.usda.gov/api-key-signup.html to get an API_KEY)


fdc = UsdaFdc::Client.new('API_KEY')

The fdc  API object can be called with a simple search string alone, with an additional options hash, or with an options hash alone (see Note).
The keys being the request parameters from the API.
##### Note
If the 'generalSearchInput' key:value is set in the options hash, it will take precedence over a supplied search term.
```
fdc.search(supplied_search_string, options => {"generalSearchInput": what_will_actually_be_searched})
```


food_search_result = fdc.search("Cheddar Cheese")

food_search_result is a hash of FDC API Response Fields with ['foods'] being an array of foods with select response fields.

You can then get all info regarding a specific food by calling the details method on the API object, with an 'fdcId' from a food.

food_details = fdc.details(food_search_result['foods'][0]['fdcId'])

food_details is a hash with keys being API Food Response Fields

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alexDude/usda_fdc-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
