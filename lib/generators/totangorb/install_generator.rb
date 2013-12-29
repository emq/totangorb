module Totangorb
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Totangorb initializer."
      def copy_initializer
        template "totangorb.rb", "config/initializers/totangorb.rb"
      end
    end
  end
end
