#
# Be sure to run `pod lib lint Domainer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Domainer'
  s.version          = '0.1.1'
s.summary          = 'Manage multi-domain url auto mapping ip address table.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Manage multi-domain url mapping IP address,it prodives find best domain which with low latency,bypass dns resolver when ip table exists the domain.
                       DESC

  s.homepage         = 'https://github.com/FelixLinBH/Domainer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'felix.lin' => 'fly_81211@hotmail.com' }
  s.source           = { :git => 'https://github.com/FelixLinBH/Domainer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Domainer/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Domainer' => ['Domainer/Assets/*.png']
  # }

  s.public_header_files = 'Domainer/Classes/**/*.h'
  s.frameworks = 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
