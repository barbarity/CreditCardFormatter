
Pod::Spec.new do |spec|
  spec.name         = "CreditCardFormatter"
  spec.version      = "0.1.0"
  spec.summary      = "A library for validating and formatting credit cards written in Swift."
  spec.description  = <<-DESC
  CreditCardFormatter offers classes for formatting and validating credit cards.
  It also offers a custom UITextField you can use in your own project to make introducing
  Credit Cards in your app as easy as ever. 
                      DESC
  spec.homepage     = "http://github.com/barbarity/CreditCardFormatter"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Joan Pérez" => "barbarityme@gmail.com" }
  spec.social_media_url   = "https://twitter.com/barbarityme"
  spec.platform     = :ios
  spec.ios.deployment_target = "10.0"
  spec.source       = { :git => "https://github.com/barbarity/CreditCardFormatter.git", :tag => spec.version }
  spec.source_files 	= "Sources/*.swift"
end
