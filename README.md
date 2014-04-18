# ProximalRecords 0.0.2

ActiveRecord extension to find out near by (proximal) records (previous and next) from the ActiveRelation scopes (using AREL).

The benefit of this gem, it can take any scope, and it does subquery for taking previous and next records.

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

Include `ProximalRecords` module into your ActiveRecord model and use it with `proximal_records` method, that returns previous and next records in the array. If previous or next records didn't found, then returns nil.

```ruby
class Article < ActiveRecord::Base
  include ProximalRecords
end


scope = Article.title_like('proximal').order('created_at DESC, title ASC')
current_record = Article.find(20) # it's part of the scope
p, n = current_record.proximal_records(scope)
```

After that you will get `previous` and `next` records, that are proximal (near by) records of current_record.


## Alternatives

- https://github.com/charly/nexter
- https://github.com/glebm/order_query


## Contributing

1. Fork it ( http://github.com/dmitry/proximal_records/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
