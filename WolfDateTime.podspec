Pod::Spec.new do |s|
    s.name             = 'WolfDateTime'
    s.version          = '1.0.1'
    s.summary          = 'A framework of structures for dealing with local dates and times.'

    # s.description      = <<-DESC
    # TODO: Add long description of the pod here.
    # DESC

    s.homepage         = 'https://github.com/wolfmcnally/WolfDateTime'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Wolf McNally' => 'wolf@wolfmcnally.com' }
    s.source           = { :git => 'https://github.com/wolfmcnally/WolfDateTime.git', :tag => s.version.to_s }

    s.source_files = 'Sources/WolfDateTime/**/*'

    s.swift_version = '5.1'

    s.ios.deployment_target = '9.3'
    s.macos.deployment_target = '10.13'
    s.tvos.deployment_target = '11.0'

    s.module_name = 'WolfDateTime'

    s.dependency 'WolfCore'
end
