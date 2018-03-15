//
//  Company.m
//  JGBlogExample
//
//  Created by Mei Jigao on 2018/3/12.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#import "Company.h"
#import <JGSourceBase/JGSourceBase.h>

@implementation Company

#pragma mark - init & dealloc
- (instancetype)initWithName:(NSString *)name tel:(NSString *)phoneNo {
    
    self = [super init];
    if (self) {
        
        _name = name;
        _telphone = phoneNo;
    }
    return self;
}

- (void)dealloc {
    
    JGLog(@"<%@: %p>", NSStringFromClass([self class]), self);
}

#pragma mark - End

@end
