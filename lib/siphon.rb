require "bundler/setup"

require "active_support/core_ext"


require "siphon/version"
require "siphon/base"

module Siphon
  # Your code goes here...

  def siphon(args)
    @siphon = Siphon::Base.new(args)
  end

  def siphon_scopes
    @siphon and Hash[ @siphon.scopes.map {|k, v| v||= "nil"; [k, v]} ]
  end


end

ActiveSupport.on_load :action_controller do
  include Siphon
  helper_method :siphon_scopes
end