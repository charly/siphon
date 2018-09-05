require "active_support/concern"

module Siphon
  module Boilerplate
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Model
      include Virtus.model
      include InstanceMethods

      cattr_accessor :model
      cattr_accessor :model_name
      cattr_accessor :table_name


      attr_reader :params_ransack # the ransack object
      attr_reader :params_siphon # the ransack object
      attr_reader :order_by # handles your order clause

    end

    module InstanceMethods
      def initialize( params = {})
        @params = params || {}

        @params_ransack= @params.slice(*self.class.ransack_set)
        @params_siphon= @params.except(*self.class.ransack_set)
        self.order_by= @params["order_by"]

        super @params_siphon
      end

      def table_name
        self.class.model.table_name
      end

      def ransack
        @relation.search( params_ransack )
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
        @result ||= begin
          relation = siphoned.merge(ransack.result)
          # reconcile all params for the search form (?)
          self.attributes= attributes.merge(params_ransack)
          relation
        end
      end
    end

    class_methods do

      def siphonize(model, model_name: nil, table_name: nil)
        name = model_name || "#{model}Search"
        self.model_name= ActiveModel::Name.new(self, nil, name)
        self.table_name= model.table_name
        @ransack_set ||= []
      end

      def ransack_set
        @ransack_set.map(&:to_s)
      end

      def ransack( attr, type= nil )
        attribute attr
        @ransack_set << attr
      end
    end
  end
end
