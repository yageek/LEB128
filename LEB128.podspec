Pod::Spec.new do |s|

  s.name         = "LEB128"
  s.version      = "2.0.0"
  s.summary      = "A library helping to deal with Little Endian Base 128."
  s.homepage     = "https://github.com/yageek/LEB128"
  s.license      = "MIT"
  s.author             = { "Yannick Heinrich" => "yannick.heinrich@gmail.com" }
  s.social_media_url   = "http://twitter.com/yageek"

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/yageek/LEB128.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/*.swift"
end
