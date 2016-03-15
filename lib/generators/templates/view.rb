= simple_form_for @<%= file_name %>_search, url: "/admin/<%= file_name.pluralize %>", method: 'GET' do |f|
  .col-md-3= f.input :name_cont
  .col-md-2= f.input :order_by, collection: <%= class_mate %>Search.order_by
  .col-md-2
    %br
    = f.button :submit, value: "search"
