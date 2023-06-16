Pod::Spec.new do |s|
  s.name             = 'SwiftExtensions'
  s.version          = '1.0.0'
  s.summary          = 'swift extensions library'
  s.description      = 'A set of Swift extensions'
  
  s.homepage         = 'https://github.com/cocomanbar/SwiftExtensions'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tanxl' => '125322078@qq.com' }
  s.source           = { :git => 'https://github.com/cocomanbar/SwiftExtensions.git', :tag => s.version.to_s }
  
  s.swift_version = '5.0'
  s.ios.deployment_target = '11.0'
  
  s.static_framework = true
  
  s.subspec 'Core' do |a|
      a.source_files = 'SwiftExtensions/Classes/Core/*'
  end
    
  s.subspec 'Bridge' do |a|
      a.source_files = 'SwiftExtensions/Classes/Bridge/*'
  end
    
  s.subspec 'Property' do |a|
      a.source_files = 'SwiftExtensions/Classes/Property/*'
  end
  
  s.subspec 'Foundation' do |a|
      a.source_files = 'SwiftExtensions/Classes/Foundation/*'
      a.dependency 'SwiftExtensions/Core'
      a.dependency 'SwiftExtensions/Bridge'
  end
  
  s.subspec 'UIKit' do |a|
      a.source_files = 'SwiftExtensions/Classes/UIKit/*'
      a.dependency 'SwiftExtensions/Foundation'
  end
  
  s.subspec 'Collection' do |a|
      a.source_files = 'SwiftExtensions/Classes/Collection/*'
  end
  
end
