//
//  Book.m
//  JGBlogExample
//
//  Created by Mei Jigao on 2018/3/14.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#import "Book.h"
#import <JGSourceBase/JGSourceBase.h>

@interface Book ()

@end

@implementation Book

#pragma mark - init & dealloc
- (instancetype)initWithName:(NSString *)name originPrice:(NSInteger)oriP publish:(NSString *)publish {
    
    self = [super init];
    if (self) {
        
        _name = name;
        _originPrice = oriP;
        _publishName = publish;
    }
    return self;
}

- (void)dealloc {
    
    JGLog(@"<%@: %p>", NSStringFromClass([self class]), self);
}

#pragma mark - Data
- (CGFloat)discount {
    
    if (self.originPrice > 0) {
        return (CGFloat)self.price / self.originPrice;
    }
    return 0;
}

#pragma mark - End

@end
