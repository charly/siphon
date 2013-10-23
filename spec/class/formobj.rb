class Formobj

  include Virtus.model

  attribute :name,  String,  default: "nabokov"
  attribute :after, Integer, default: 1950
  attribute :admin, Boolean, default: false
  attribute :order, String

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