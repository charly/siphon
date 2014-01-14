class SiphonGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  def create_search_file
    template "search.rb", File.join('app/siphon', class_path, "#{file_name}_search.rb")
  end
end