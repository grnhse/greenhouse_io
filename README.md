# Greenhouse

A Ruby interface to
[Greenhouse.io's](https://app.greenhouse.io/jobboard/jsonp_instructions)
API.

## Installation

Add this line to your application's Gemfile:

    gem 'greenhouse'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install greenhouse

## Usage

Creating an instance of the API client:
```ruby
gh = Greenhouse::API.new("api_token")
```

The client will also use the environment variable `'GREENHOUSE_API_TOKEN'` by default:
```ruby
gh = Greenhouse::API.new
```

A default organization can be passed through an options hash:
```ruby
gh = Greenhouse::API.new("api_token", { :organization => "your_organization" })
```

### Fetching Office Data
```ruby
gh.offices
gh.offices({ :organization => 'different_organization' })
# returns a hash containing all of the organization's department and jobs grouped by office
```

```ruby
gh.office(officeID)
gh.office(officeID, { :organization => 'different_organization' })
# returns a hash containing the departments and jobs of a specific office
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
