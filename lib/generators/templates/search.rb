# uncomment `q` lines for combining ransack with your scope search
class <%= class_name %>Search

  include ActiveModel::Model
  include Virtus.model

  attribute :full_name, String

  # attr_reader :q        # the nested ransack object
  # attr_reader :order_by # handles your order clause

  def initialize(params = {})
    @params = params || {}
    super(params)
    # self.q= @params[:q]
    # self.order_by= @params[:order_by]
  end

  # Example of conditionally applying search terms.
  # def done
  #   return false unless @params[:q]
  #   @params[:q][:state_eq].blank? ? @done : ""
  # end

  def result
    <%= class_name %>.scoped.order(order_by).merge(q.result).merge(siphoned)
  end

  # Exmaple of Search Form handling order stuff (might not be the best place)
  # def self.order_by
  #   [['newest',"created_at DESC"],
  #     ["oldest", "created_at"],
  #     ["state", "state, created_at"]]
  # end

  # Example of default ordering
  # def order_by=( val )
  #   @order_by = val.blank? ? "created_at DESC" : val
  # end


  # def q=(sub_form_hash = {})
  #   @q = <%= class_name %>.search( sub_form_hash )
  # end

private

  def siphoned
    Siphon::Base.new(<%= class_name %>.scoped).scope( self )
  end


end