# Greenhouse

[![Gem
Version](https://badge.fury.io/rb/greenhouse_io.png)](http://badge.fury.io/rb/greenhouse_io)
[![Build
Status](https://travis-ci.org/adrianbautista/greenhouse_io.png)](https://travis-ci.org/adrianbautista/greenhouse_io)
[![Coverage Status](https://coveralls.io/repos/adrianbautista/greenhouse_io/badge.png)](https://coveralls.io/r/adrianbautista/greenhouse_io)

A Ruby interface to
[Greenhouse.io's](https://app.greenhouse.io/jobboard/jsonp_instructions)
API.

## Installation

Add this line to your application's Gemfile:

    gem 'greenhouse_io'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install greenhouse_io

## Usage

Creating an instance of the API client:
```ruby
gh = GreenhouseIo::API.new("api_token")
```

The client will also use the environment variable `'GREENHOUSE_API_TOKEN'` by default:
```ruby
gh = GreenhouseIo::API.new
```

A default organization can be passed through an options hash:
```ruby
gh = GreenhouseIo::API.new("api_token", :organization => "your_organization")
```

### Fetching Office Data
```ruby
gh.offices
gh.offices(:organization => 'different_organization')
# returns a hash containing all of the organization's department and jobs grouped by office
```

```ruby
gh.office(officeID)
gh.office(officeID, :organization => 'different_organization')
# returns a hash containing the departments and jobs of a specific office
```

### Fetching Department Data
```ruby
gh.departments
gh.departments(:organization => 'different_organizaton')
```

```ruby
gh.department(departmentID)
gh.department(departmentID, :organization => 'different_organization')
```

### Fetching Job Data
```ruby
gh.jobs
gh.jobs(:content => 'true')
# includes the job description in the response
gh.jobs(:organization => 'different_organization')
```

```ruby
gh.job(jobID)
gh.job(jobID, :questions => true)
# returns the specified job and the array of questions on the application
gh.job(jobID, :organization => 'different_organization')
```

### Submitting a Job Application
This is the only API method that **requires** an API token from Greenhouse
```ruby
gh.apply_to_job(form_parameter_hash)

# form_parameter_hash should match the questions array of a given job opening
# there should be a hidden input with name id in your form that
# has the value of the job ID on Greenhouse.io
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
