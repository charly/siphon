# uncomment `q` lines for combining ransack with your scope search
class <%= class_name %>Search

  include Siphon::Boilerplate
  siphonize class_name

  #
  # Scope attributes
  #
  # attribute :tree_id,   Integer
  # attribute :is_public, Boolean

  #
  # ransack attributes
  #
  # ransack :category_id_eq
  # ransack :title_cont



  # Exmaple of Search Form handling order stuff (might not be the best place)
  def self.order_by
    [['newest',"#{table_name}.created_at DESC"],
      ["oldest", "#{table_name}.created_at"],
      ["category", "#{table_name}.category_id, #{table_name}.id"]
      # ["popularity", "sales_num DESC"]]
    ]
  end

  # Example of default ordering
  def order_by=( val )
    @order_by = val.blank? ? "#{table_name}.created_at DESC" : val
  end
end