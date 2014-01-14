# Siphon

Siphon's a minimalistic gem which enables you to easily and conditionnaly apply your ActiveRecord scopes with parameteres sent through the web.


## Installation

Add this line to your application's Gemfile:

    gem 'siphon'


## Usage

So Siphon's just a tiny convienience gem which is still quit experimental but it does its job of applying scopes to an activerecord model thanks to a formobject (using the great [virtus][1] here) containing the coerced values. 
Here's how it works :

### The Scopes :

```ruby
# order.rb
class Order < ActiveRecord::Base
  scope :stale, ->(duration) { where(["state='onhold' OR (state != 'done' AND updated_at < ?)", duration.ago]) }
  scope :unpaid -> { where(paid: false) }
end
```

### The Form :

```ruby
= form_for @order_form do |f|
  = f.label :stale, "Stale since more than"
  = f.select :stale, [["1 week", 1.week], ["3 weeks", 3.weeks], ["3 months", 3.months]], include_blank: true
  = f.label :unpaid
  = f.check_box :unpaid
```


### The Form Object:

```ruby
# order_form.rb
class OrderForm
  include Virtus.model
  include ActiveModel::Model
  #
  # attribute are the named scopes and their value are :
  # - either the value you pass a scope which takes arguments
  # - either a Siphon::Nil value to apply (or not) a scope which has no argument
  #
  attribute :stale, Integer
  attribute :unpaid, Siphon::Nil
end
```


### Aaaaand... TADA siphon :

```ruby
# orders_controller.rb
def search
  @order_form = OrderForm.new(params[:order_form])
  @orders = siphon(Order.all).scope(@order_form)
end
```

Here's how it works : it takes an initial ActiveRelation (Order.all) and then from a FormObject (@order_form) it will apply or not a set of scopes with typecasted arguments.


## Advanced Usage

You may want to check [how to combine siphon with ransack][2]


## Some Insights

Siphon stands on the giant shoulder of Virtus which takes care of coercing the string values a form sends to the controller. But coercing is only solving one part of the problem. This is where siphon comes into play :

As you saw in the example a scope either takes an argument(s) or it doesn't so the idea is :

1. either the field holds a value which is meant to be passed to the scope (like a date, a name, a duration, etc).
2. either the scopes takes no argument and the boolean field (like a check box) only indicates if you want it applied or not.

So the values have two distinctive roles .

In the case of `stale` which takes a duration :

```ruby
= form_for @order_form do |f|
  = f.label :stale, "Stale since more than"
  = f.select :stale, [["1 week", 1], ["3 weeks", 3], include_blank: true
```

If you select a duration the scope will be called and the argument will be turned into an integer and passed as an arg.
But if you select the blank option the value of params[:stale] will be an empty string. Siphon knows it should be an integer thanks to the formobject and concludes this means no values are passed to the scope and therefore shouldn't be called.

In the case of `unpaid` siphon knows it doesn't take any argument (Siphon::Nil) and therefore only calls the scope of the field when it's not falsy ("0", "f", "false" etc).

That's all!

## Alternate Libs

* [has_scope](https://github.com/plataformatec/has_scope)
* [periscope](https://github.com/laserlemon/periscope)
* [scoped_from](https://github.com/alexistoulotte/scoped_from)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[1]: https://github.com/solnic/virtus
[2]: https://coderwall.com/p/4zz6ca


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/charly/siphon/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

