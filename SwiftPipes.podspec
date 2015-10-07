Pod::Spec.new do |s|
  s.name             = "SwiftPipes"
  s.version          = "0.1.0"
  s.summary          = "Pipes, currying, function composition for Swift"

  s.description      = <<-DESC
    Essential components for the functional Swift programmer.
    Pipes, currying, function composition.
                       DESC

  s.homepage         = "https://github.com/timbodeit/SwiftPipes"
  s.license          = 'MIT'
  s.author           = { "Tim Bodeit" => "tim@bodeit.com" }
  s.source           = { :git => "https://github.com/timbodeit/SwiftPipes.git", :tag => s.version.to_s }

  s.ios.deployment_target = "8.0"
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
end
