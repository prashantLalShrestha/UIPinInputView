Pod::Spec.new do |spec|
  spec.name = "UIPinInputView"
  spec.version = "1.0.0"
  spec.summary = "UIPinInputView is just a simple CoreFoundationKit utility Module"

  spec.description = <<-DESC
  This module contains the tab bar controller with a circular button at center
                   DESC

  spec.homepage = "https://github.com/prashantLalShrestha/UIPinInputView"
  # spec.screenshots = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.authors = { 
    "Prashant Shrestha" => "prashantlurvs@gmail.com" 
  }
  # spec.social_media_url   = "https://twitter.com/Prashant Shrestha"
  
  spec.ios.deployment_target = '11.0'
  # spec.source = { :git => '' }
  spec.source = { 
    :git => "https://github.com/prashantLalShrestha/UIPinInputView.git", :tag => spec.version.to_s
  }
  
  spec.source_files = 'Sources/**/*.{swift}'
  # spec.exclude_files = "CoreDeviceKit/Exclude"

  spec.swift_version = "5.0"

  # spec.public_header_files = "CoreDeviceKit/**/*.h"

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"
  # spec.resource_bundle  = {
  #   "KeyboardAsset" => "Sources/**/*.{xcassets}"
  # }

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"

  spec.frameworks = "UIKit", "Foundation"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  spec.dependency "DeviceX"

end
