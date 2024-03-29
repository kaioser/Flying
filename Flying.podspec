#
# Be sure to run `pod lib lint Flying.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Flying'
  s.version          = '0.1.2'
  s.summary          = '网络请求'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.description      = <<-DESC
  TODO: Add long description of the pod here.
  DESC
  
  s.homepage         = 'https://github.com/kaioser/Flying'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yangxiongkai' => 'yangxiongkai@126.com' }
  s.source           = { :git => 'https://github.com/kaioser/Flying.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '14.0'
  s.swift_version = '5.0'
  s.source_files = 'Flying/Classes/**/*'
  
  s.dependency 'Moya'
  
end
