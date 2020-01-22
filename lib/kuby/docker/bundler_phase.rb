module Kuby
  module Docker
    class BundlerPhase < Phase
      DEFAULT_WITHOUT = ['development', 'test']

      attr_accessor :version, :gemfile, :without

      def apply_to(dockerfile)
        gf = gemfile || default_gemfile
        lf = "#{gf}.lock"
        v = version || default_version
        wo = without || DEFAULT_WITHOUT

        dockerfile.run("gem install bundler -v #{v}")

        # bundle install
        dockerfile.copy(gf, '.')
        dockerfile.copy(lf, '.')

        # set bundle path so docker will cache the bundle
        dockerfile.run('mkdir ./bundle')
        dockerfile.env('BUNDLE_PATH=./bundle')

        unless wo.empty?
          dockerfile.env("BUNDLE_WITHOUT='#{wo.join(' ')}'")
        end

        cmd = [
          'bundle', 'install',
          '--jobs', '3',
          '--retry', '3',
          '--gemfile', gf
        ]

        dockerfile.run(cmd)

        # generate binstubs and add the bin directory to our path
        dockerfile.run('bundle binstubs --all')
        dockerfile.env("PATH=./bin:$PATH")
      end

      private

      def default_version
        Bundler::VERSION
      end

      def default_gemfile
        Bundler
          .definition
          .gemfiles
          .first
          .relative_path_from(app.root)
          .to_s
      end
    end
  end
end
