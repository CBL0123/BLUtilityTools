
Pod::Spec.new do |bl|
bl.name = 'BLUtilityTools'
bl.version = '1.0.0'
bl.license= { :type => "MIT", :file => "LICENSE"}
bl.summary = 'made by cbl and I am testing'
bl.homepage =  'https://github.com/CBL0123/BLUtilityTools'
bl.authors = { 'CBL0123' => '877900326@qq.com'}
bl.source = { :git =>  "https://github.com/CBL0123/BLUtilityTools.git", :tag => bl.version}
bl.requires_arc = true
bl.ios.deployment_target = '9.0'
bl.source_files = 'BLUtilityTool.{h,m}','BLBlockDefine.{h}','NSString+Util.{h,m}'
bl.frameworks = 'UIKit' , 'Foundation'
end