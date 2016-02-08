class <%= class_name.pluralize %>Controller < ApplicationController
  # include Paramount::Controller

  def new
    @<%= file_name %> ||= <%= class_mate %>.new
  end

private
  def collection
    @<%= file_name.pluralize %> ||= get_search.result.page(params[:page])
  end

  def resource
    @<%= file_name %> ||= <%= class_mate %>.find(params[:id])
  end

  def get_search
    @<%= file_name %>_search ||= <%= class_mate %>Search.new(params[:<%= file_name %>_search])
  end

  def resource_params
    params.require(:<%= file_name %>).permit!
  end

  def redirection(action:)
    redirect_to [resource], notice: "Successfuly #{action} !"
  end
end