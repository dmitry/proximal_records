# ProximalRecords

ActiveRecord extension to find out near by (proximal) records (previous and next) from the ActiveRelation scopes (using AREL).

### Supported adapters

* mysql2
* postgresql

### Tested on

* Ruby: 1.9.3, 2.0.0, 2.1.1
* ActiveRecord: 3.2, 4.0, 4.1

[![Build Status](https://travis-ci.org/dmitry/proximal_records.svg?branch=master)](https://travis-ci.org/dmitry/proximal_records)


## Installation

Add this line to your application's Gemfile:

    gem 'proximal_records'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install proximal_records


## Usage

```ruby
    scope = Article.title_like('proximal').order('created_at DESC, title ASC')
    current_record = Article.find(20) # it's part of the scope
    previous, next = current_record.proximal_records(scope)
```

After that you will get `previous` and `next` records, that are proximal (or near by) records of current_record.


## Contributing

1. Fork it ( http://github.com/<my-github-username>/proximal_records/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
