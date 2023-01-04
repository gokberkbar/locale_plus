#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint locale_plus.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'locale_plus'
  s.version          = '1.0.0'
  s.summary          = 'LocalePlus allows easy access to native device locale data in Flutter apps.'
  s.description      = <<-DESC
  LocalePlus allows easy access to native device locale data in Flutter apps. Includes language, country code, time zone, and number formatting preferences.
                       DESC
  s.homepage         = 'https://github.com/gokberkbar/locale_plus'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'gokberkbar' => 'gokberkbar@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
