
Pod::Spec.new do |spec|

  spec.name         = "FloatingBubbles"
  spec.version      = "1.0.2"
  spec.summary      = "FloatingBubbles"
  spec.description  = "A view that hold floating bubbles with zero gravity."
  spec.homepage     = "https://github.com/chandansharda/FloatingBubbles"
  spec.license      = "MIT"
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/chandansharda/FloatingBubbles.git", :tag => "1.0.2" }
  spec.author             = { "Chandan Sharda" => "chandan.sharda98@gmail.com" }

  spec.source_files  = "FloatingBubbles/**/*.{swift,h,m}"
  spec.swift_versions = "5.0"
  
  end
