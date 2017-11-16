

Pod::Spec.new do |s|

  s.name         = "ShineHud"
  s.version      = "0.1.2"
  s.summary      = "Swift 轻量级HUD框架"

  s.description  = <<-DESC
                  轻量级框架使用方便,基于Swift4.0,持续更新
                   DESC

  s.homepage     = "https://github.com/Echo-BraveShine/ShineHud"


  s.license      = "MIT"

  s.author             = { "BraceShine" => "1239383708@qq.com" }

  s.source       = { :git => "https://github.com/Echo-BraveShine/ShineHud.git", :tag => "v#{s.version}" }

  s.platform = :ios, "9.0"

  s.source_files  = "ShineHud/ShineHud/ShineHud/*.{swift}"

  s.framework  = "UIKit"
  s.resources = 'ShineHud/ShineHud/Resource/*.{png,xib,plist}'



end
