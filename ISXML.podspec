#
#  Be sure to run `pod spec lint ISXML.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name          = "ISXML"
  spec.version       = "0.1.0"
  spec.summary       = "ISXML is a class designed to simplify a process of XML generation."
  spec.homepage      = "https://github.com/ilyashvedikov/ISXML"
  spec.license       = { :type => "MIT", :file => "LICENSE" }
  spec.author        = { "Ilya Shvedikov" => "i.shvedikov@besmart.by" }
  spec.platform      = :ios, "8.0"
  spec.source        = { :git => "https://github.com/ilyashvedikov/ISXML.git", :tag => "#{spec.version}" }
  spec.source_files  = "ISXML/Classes/*.{h,m}"
  spec.requires_arc = true

end
