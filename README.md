# Siphon

Siphon's a minimalistic gem which enables you to easily apply/combine/exclude your ActiveRecord scopes with params.

## Installation

Add this line to your application's Gemfile:

    gem 'siphon'

## Usage

Siphon is super simple and can be easily overidden. However for basic usage it has a couple of helpers.

### Basic Usage

    ```ruby
    #books_controller.rb
    
    def index
      @books ||= Siphon.new(Book.includes(:auhtor)).
                        has_scopes({year: integer, author_name: :string}).filter(params)
    end

### Advanced Usage
TODO: More examples

    # books_siphon.rb
    BookSiphon < Siphon
      
      def initialize
        super
        has_scopes({some: :integer, default: :boolean, scopes: nil})
      end
    
      # def default
      #   relation.paginate(:page => params[:page])
      # end
    end

## Why Siphon ?

Thanks to Arel & ActiveRelation, Rails has an extraordinary, super powerful API to create scopes. You can chain them, merge them, pass them around, in what ever order you want, they'll just build the SQL you expect and only fire when necessary. 

However once you're in the controller all this beauty is lost if you want to start applying scopes conditionally - e.g : depending on params in the url.

One way of doing it is like that :

    def index
      @results = Results.scoped
      @results = @results.gender(params[:gender]) if params[:gender]
      @results = @results.career(params[:career]) if params[:career]
    end

It's ugly, it doesn't scale and each time I see an `if` I hear the squeeking sound of a tree falling in the rain forest to build another Mc Donalds.

## Why not Has_Scope ?

So what about has_scope ?

    # books_controller.rb
    has_scope :gender
    has_scope :career
    
    def index
      @results = apply_scopes(Results).all
    end

and yee it was build by the awesome José Valim. But in my taste it suffers from the same problem Paperclip and all gem which rely on configuration with hashes have : Hashitis. 

    # tree_controller.rb
    has_scope :color, :unless => :show_all_colors?
    has_scope :only_tall, :type => :boolean, :only => :index, :if => :restrict_to_only_tall_trees?
    has_scope :shadown_range, :default => 10, :except => [ :index, :show, :new ]
    has_scope :root_type, :as => :root, :allow_blank => true
    has_scope :calculate_height, :default => proc {|c| c.session[:height] || 20 }, :only => :new

As soon as you reach a certain level of complexity it looks as bad as if nested ifs were crawling all over your code. That's why most of us go for CarrierWave today : because well if you need behaviour why try to invent another DSL when you already have the best at hands : RUBY !

* You unclutter your controllers - which I like anorexic.
* You're not limited by the set of configuration the gem gives you.
* you can apply as much logic as you whish 
* It's encapsultated, unit-testable & respects SRP

Actually Siphon shouln't even be a gem but just a set of guidelines. But hey it has a cool name...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
