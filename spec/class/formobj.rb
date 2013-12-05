class Formobj

  include Virtus.model

  attribute :name,  String
  attribute :after, Integer
  attribute :admin, Boolean
  attribute :order, String
  attribute :stale, Siphon::Nil

  attr_accessor :sinfull

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations


  # def initialize(params = {})
  #   params.each do |attr, value|
  #     self.public_send("#{attr}=", value)
  #   end if params

  #   super()
  # end

  def scopes
    attributes
  end


end