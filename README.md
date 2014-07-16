# ProximalRecords 0.0.2

ActiveRecord extension to find out near by (proximal) records (previous and next) from the ActiveRelation scopes (using AREL).

The benefit of this gem, it can take any scope, and it does subquery for taking previous and next records.
Next and previous records will be found based on all the clauses used in the scope. ORDER, JOINs, LIMIT and other clauses will be persisted. No manual setup required.

### Supported adapters

* mysql2
* postgresql

### Impossible to support adapters

* sqlite3

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

Setup ActiveRecord model with including the `ProximalRecords` module.

```ruby
class Article < ActiveRecord::Base
  include ProximalRecords
end
```

Then use it with `proximal_records` method, which takes a record that is part of the scope.
It returns an array with 2 elements: previous as the first element and next as the second.
If previous or next records wasn't found (when the relation record has the first or the last position in the scope), it returns `nil` for this element.

```ruby
scope = Article.title_like('proximal').order('created_at DESC, title ASC')
current_record = Article.find(20)
previous_record, next_record = current_record.proximal_records(scope)
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