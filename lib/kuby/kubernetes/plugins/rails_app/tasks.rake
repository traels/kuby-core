require 'rake'

namespace :kuby do
  namespace :rails_app do
    namespace :db do
      task :rewrite_config do
        Kuby.load!

        config_file = File.join(Kuby.definition.kubernetes.plugin(:rails_app).root, 'config', 'database.yml')
        database = Kuby.definition.kubernetes.plugin(:rails_app).database

        if database.respond_to?(:rewritten_configs)
          File.write(config_file, YAML.dump(database.rewritten_configs))
          Kuby.logger.info("Wrote #{config_file}")
        end
      end

      task :create_unless_exists do
        begin
          Rake::Task['environment'].invoke
          ActiveRecord::Base.connection
        rescue ActiveRecord::NoDatabaseError => e
          Rake::Task['db:create'].invoke
        end
      end
    end
  end
end
