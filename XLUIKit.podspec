Pod::Spec.new do |s|

  s.name         = "XLUIKit"
  s.version      = "1.0.1"
  s.summary      = "XLUIKit."
  s.requires_arc = true
  s.description  = <<-DESC
                    UI库
                   DESC
  s.author = { "XL" => "XL" }
  s.ios.deployment_target = '8.0'
  s.source       = { :git => "git@github.com:bojy123/XLUIKit.git" , :tag => s.version.to_s}

  s.dependency 'MBProgressHUD', '1.2.0'
  s.source_files = 'ModuleCode/*.{h,m}'
  s.resources = "ModuleCode/**/*.{xcassets,strings,xml,storyboard,xib,xcdatamodeld}"
  s.vendored_libraries = "ModuleCode/**/*.{a}"
  
  s.subspec 'Controller' do |s2|
      s2.source_files = 'ModuleCode/Controller/**/*.{h,m}'
  end
  
  s.subspec 'Manager' do |s2|
      s2.source_files = 'ModuleCode/Manager/**/*.{h,m}'
  end

end
