require 'rails/generators/migration'

module SpreePayuIn
  module Generators
    class InstallGenerator < Rails::Generators::Base

      include Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)
      desc "add the migrations"

      def add_javascripts
        append_file 'app/assets/javascripts/store/all.js', "//= require store/spree_payu_in\n"
        append_file 'app/assets/javascripts/admin/all.js', "//= require admin/spree_payu_in\n"
      end

      def add_stylesheets
        inject_into_file 'app/assets/stylesheets/store/all.css', " *= require store/spree_payu_in\n", :before => /\*\//, :verbose => true
        inject_into_file 'app/assets/stylesheets/admin/all.css', " *= require admin/spree_payu_in\n", :before => /\*\//, :verbose => true
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_payu_in'
      end

      def run_migrations
         res = ask 'Would you like to run the migrations now? [Y/n]'
         if res == '' || res.downcase == 'y'
           run 'bundle exec rake db:migrate'
         else
           puts 'Skiping rake db:migrate, don\'t forget to run it!'
         end
      end

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template "create_payu_payments.rb", "db/migrate/create_payu_payments.rb"
      end

    end
  end
end
