require "active_support/concern"

module Siphon
  module Scope
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Model
      include Virtus.model
      include InstanceMethods

      cattr_accessor :model
      cattr_accessor :model_name
      cattr_accessor :table_name


      attr_reader :ransack_attributes # for the Ransack object
      attr_reader :siphon_attributes # for the Siphon object
      attr_reader :order_by # handles your order clause
    end

    module InstanceMethods
      def initialize( params = {})
        @params = convert_to_hash(params)
        super @params

        @ransack_attributes = attributes.slice(*self.class.ransack_set)
        @siphon_attributes  = attributes.slice(*self.class.siphon_set)

        self.order_by   = @params["order_by"]
      end

      def convert_to_hash(params)
        if params.nil?
          {}
        elsif params.respond_to?(:permit!)
          params.permit!
        elsif params.respond_to?(:with_indifferent_access)
          params.with_indifferent_access
        else
          params
        end
      end

      def table_name
        self.class.model.table_name
      end

      def ransack
        @relation.search(ransack_attributes)
      end

      def merge(relation)
        @relation = @relation.merge(relation)
        self
      end

      def siphoned
        Siphon::Base.new(@relation).scope( self )
      end

      # memoized or it'll break after attributes reconciled
      def result
        @result ||= siphoned.merge(ransack.result)
      end

      def preformat_date(value = nil)
        value.is_a?(String) && value.present? ? Date.strptime(value, I18n.t('date.formats.long')) : value
      end
    end

    class_methods do

      def siphonize(model, model_name: nil, table_name: nil)
        name = model_name || "#{model}Search"
        self.model_name= ActiveModel::Name.new(self, nil, name)
        self.table_name= model.table_name
        @ransack_set ||= []
        @siphon_set ||= []
      end

      def ransack_set
        @ransack_set
      end

      def siphon_set
        @siphon_set
      end

      def scope(attr, type = nil)
        type.nil? ? attribute(attr) : attribute(attr, type)
        @siphon_set << attr
      end

      def ransack(attr, type = nil)
        type.nil? ? attribute(attr) : attribute(attr, type)
        @ransack_set << attr
      end
    end
  end
end
