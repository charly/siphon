class SiphonGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  def create_search_file
    template "search.rb", File.join('app/siphon', class_path, "#{file_name}_search.rb")
  end

  def create_controller
    template "controller.rb", File.join('app/controllers', class_path, "#{file_name.pluralize}_controller.rb")
  end

  def create_view
    template "view.rb", File.join('app/views', class_path, "#{file_name.pluralize}", "_search.html.haml")
  end


  def class_mate
    classy = begin
       Object.const_get(class_name) ||
       Object.const_get( file_name.classify)
    rescue
    end
  end

end