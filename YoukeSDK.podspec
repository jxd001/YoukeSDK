Pod::Spec.new do |s|
  s.name             = "YoukeSDK"
  s.version          = "1.0.0"
  s.summary          = "YoukeSDK帮助你的APP快速构建客服系统。"
  s.homepage         = "https://github.com/jxd001/YoukeSDK"
  s.license          = 'MIT'
  s.author           = { "jxd001" => "http://weibo.com/jxd001" }
  s.source           = { :git => "https://github.com/jxd001/YoukeSDK.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'YoukeSDK/*'

  s.frameworks = 'libresolv', 'libsqlite3', 'libxml2'

end
