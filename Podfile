source 'https://github.com/CocoaPods/Specs.git'

inhibit_all_warnings!
use_frameworks!

# workspace
workspace "JGBlogExample"

# platform
platform :ios, '9.0'

# JGBlogExample
target "JGBlogExample" do
    
    # JGSourceCode
    # JGSourceCode 执行了pod依赖，则此处可注释掉
    # JGSourceCode 未执行pod依赖，则此处不可注释掉，用于JGSourceCode开发测试
    pod 'JGSourceCode' #, :path => "."

    # project
    project "JGBlogExample/JGBlogExample.xcodeproj"
end

