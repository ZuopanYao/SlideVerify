Pod::Spec.new do |spec|

spec.name                  = 'SlideVerify'

spec.version               = '0.0.2'

spec.ios.deployment_target = '9.0'

spec.license               = 'MIT'

spec.homepage              = 'https://git.coding.net/yao7778899/SlideVerify.git'

spec.author                = { "ZuopanYao" => "yaozuopan@icloud.com" }

spec.summary               = '这是一个滑动验证码框架.'

spec.description    	   = "这是一个滑动验证码框架,方便集成使用."

spec.source                = { :git => 'https://git.coding.net/yao7778899/SlideVerify.git', :tag => spec.version }

spec.source_files          = "SlideVerify/SlideVerify/Source/*.{h,m}"

spec.resources             = "SlideVerify/SlideVerify/Resources/*.png"

spec.public_header_files   = "SlideVerify/SlideVerify/Source/{SlideVerify.h,SVSlideVerifyView.h,SVSlideBarView.h}"

spec.frameworks            = 'UIKit', 'Foundation'

spec.requires_arc          = true

end
