Pod::Spec.new do |s|
  s.name        = "HSongHtmlLabel"
  s.version     = "0.1.0"
  s.summary     = "Let your UILabel load html tags"
  s.homepage    = "https://github.com/Thered-key/HSongHtmlLabel"
  s.license     = { :type => "MIT" }
  s.authors     = { "Thered-key" => "wereaiyou@163.com" }

  s.requires_arc = true
  s.swift_version = "5.0"

  #s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "12.0"
  #s.watchos.deployment_target = "2.0"
  #s.tvos.deployment_target = "9.0"

  s.source   = { :git => "https://github.com/Thered-key/HSongHtmlLabel.git", :tag => s.version }
  s.source_files = "HSongHtmlLabel/*.{h,m,swift}"
  s.public_header_files = "HSongHtmlLabel/*.h"

  s.dependency 'DTCoreText'

end