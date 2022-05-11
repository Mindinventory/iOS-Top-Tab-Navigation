Pod::Spec.new do |s|
s.name             = 'TopTabBarView'
s.version          = '1.0.1'
s.summary          = 'Wave animation view for tabs only used for iOS'
s.description      = <<-DESC
This CocoaPods library helps you to add wave animation tabs in app and makes your app look fantastic!
DESC

s.homepage         = 'https://github.com/parthgohel2810/TopTabBarView-Framework.git'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { "Parth Gohel" => "parth.gohel@mindinventory.com" }
s.source           = { :git => 'https://github.com/parthgohel2810/TopTabBarView-Framework.git', :tag => "#v{s.version}" }
s.platform     = :ios, "13.0"
s.swift_version = '5.0'
s.ios.deployment_target = '13.0'
s.source_files  = "TopTabBarView/Source/**/*.swift"
end
