module Kuby
  module Docker
    autoload :AssetsPhase,    'kuby/docker/assets_phase'
    autoload :Builder,        'kuby/docker/builder'
    autoload :BundlerPhase,   'kuby/docker/bundler_phase'
    autoload :CopyPhase,      'kuby/docker/copy_phase'
    autoload :Dockerfile,     'kuby/docker/dockerfile'
    autoload :LayerStack,     'kuby/docker/layer_stack'
    autoload :PackagePhase,   'kuby/docker/package_phase'
    autoload :Phase,          'kuby/docker/phase'
    autoload :SetupPhase,     'kuby/docker/setup_phase'
    autoload :WebserverPhase, 'kuby/docker/webserver_phase'
    autoload :YarnPhase,      'kuby/docker/yarn_phase'
  end
end
