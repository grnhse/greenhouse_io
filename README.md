# Greenhouse IO

[![Gem
Version](https://badge.fury.io/rb/greenhouse_io.png)](http://badge.fury.io/rb/greenhouse_io)
[![Build
Status](https://travis-ci.org/adrianbautista/greenhouse_io.png)](https://travis-ci.org/adrianbautista/greenhouse_io)
[![Coverage Status](https://coveralls.io/repos/adrianbautista/greenhouse_io/badge.png)](https://coveralls.io/r/adrianbautista/greenhouse_io)

A Ruby interface to
[Greenhouse.io's](https://app.greenhouse.io/jobboard/jsonp_instructions)
API (requires Ruby 1.9.3 or greater).

## Installation

Add the gem to your application's Gemfile:

    gem 'greenhouse_io'

Or install it yourself as:

    $ gem install greenhouse_io
    
## Configuration

You can assign default configuration values when using this gem.  
Here is an example `config/initializers/greenhouse_io.rb` file used in a Rails application:

```ruby
GreenhouseIo.configure do |config|
	config.symbolize_keys = true # set response keys as strings or symbols, default is false
	config.organization = 'General Assembly'
	config.api_token = ENV['GREENHOUSE_API_TOKEN']
end
```

## Usage

Greenhouse's two APIs, **[Harvest](https://app.greenhouse.io/configure/dev_center/harvest)** and **[JobBoard](https://app.greenhouse.io/configure/dev_center/api_documentation)**, can now be accessed through the gem. The [`GreenhouseIo::JobBoard`](#greenhouseiojobboard) is nearly identical to the old `GreenhouseIo::API` class. [`GreenhouseIo::Client`](#greenhouseioclient) connects to the new Harvest API.

### GreenhouseIo::JobBoard

Creating an instance of the JobBoard client:
```ruby
gh = GreenhouseIo::JobBoard.new("api_token", organization: "your_organization")
```

If you've configured the gem with a default `organization` and `api_token`, then you can just instantiate the class.
```ruby
gh = GreenhouseIo::JobBoard.new
```

`api_token` is only required for `#apply_to_job` and `organization` is also optional during initialization if an organization is passed in during method requests.

#### Fetching Office Data
```ruby
gh.offices
gh.offices(organization: 'different_organization')
# returns a hash containing all of the organization's department and jobs grouped by office
```

```ruby
gh.office(id)
gh.office(id, organization: 'different_organization')
# returns a hash containing the departments and jobs of a specific office
```

#### Fetching Department Data
```ruby
gh.departments
gh.departments(organization: 'different_organizaton')
```

```ruby
gh.department(id)
gh.department(id, organization: 'different_organization')
```

#### Fetching Job Data
```ruby
gh.jobs
gh.jobs(content: 'true')
# includes the job description in the response
gh.jobs(organization: 'different_organization')
```

```ruby
gh.job(id)
gh.job(id, questions: true)
# returns the specified job and the array of questions on the application
gh.job(id, organization: 'different_organization')
```

#### Submitting a Job Application
This is the only API method that **requires** an API token from Greenhouse
```ruby
gh.apply_to_job(form_parameter_hash)

# form_parameter_hash should match the questions array of a given job opening
# there should be a hidden input with name id in your form that
# has the value of the job ID on Greenhouse.io
```

### GreenhouseIo::Client

Creating an instance of the API client:
```ruby
gh_client = GreenhouseIo::Client.new("api_token")
```

If you've configured the gem with a default `api_token`, then you can just instantiate the class.
```ruby
gh_client = GreenhouseIo::Client.new
```

#### Throttling

Rate limit and rate limit remaining are available after making an API request with an API client:

```ruby
gh_client.rate_limit # => 20
gh_client.rate_limit_remaining  # => 20
```

#### Pagination

All `GreenhouseIo::Client` API methods accept `:page` and `:per_page` options to get specific results of a paginated response from Greenhouse.

```ruby
gh_client.offices(id, page: 1, per_page: 2)
```

#### Available methods

Methods in which an `id` is optional:

* `offices`
* `departments`
* `candidates`
* `applications`
* `jobs`
* `users`
* `sources`

Methods in which an `id` is **required**:

* `activity_feed` *(requires a candidate ID)*
* `scorecards` *(requires an application ID)*
* `scheduled_interviews` *(requires an application ID)*
* `stages` *(requires a job ID)*
* `job_post` *(requires a job ID)*

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
