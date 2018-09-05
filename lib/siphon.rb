require "bundler/setup"

require "active_support"
require "active_support/core_ext"

require "siphon/version"
require "siphon/base"
require "siphon/adapter"
require "siphon/nil"
require "siphon/boilerplate"
require "siphon/scope"

module Siphon
  # Your code goes here...

  def siphon(args)
    @siphon = Siphon::Base.new(args)
  end

end

ActiveSupport.on_load :action_controller do
  include Siphon
end
