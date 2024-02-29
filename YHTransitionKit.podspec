#
# Be sure to run `pod lib lint YHTransitionKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YHTransitionKit'
  s.version          = '0.1.3'
  s.summary          = 'Push/Pop and Present/Dismiss animated/gesture of YHTransitionKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Implement by categroy, push/pop and present/dismiss animated/gesture of YHTransitionKit, better to use.
                       DESC

  s.homepage         = 'https://github.com/yelinux/YHTransitionKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ye_linux@126.com' => 'ye_linux@126.com' }
  s.source           = { :git => 'https://github.com/yelinux/YHTransitionKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  # s.source_files = 'YHTransitionKit/Classes/**/*'
  
  s.subspec 'NavigationBar' do |s|
    s.source_files = 'YHTransitionKit/Classes/NavigationBar/**/*'
  end
  
  s.subspec 'PresentDismiss' do |s|
    s.source_files = 'YHTransitionKit/Classes/PresentDismiss/**/*'
  end
  
  # s.resource_bundles = {
  #   'YHTransitionKit' => ['YHTransitionKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
