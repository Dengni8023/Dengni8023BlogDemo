//
//  KVOBook.m
//  JGBlogExample
//
//  Created by Mei Jigao on 2018/3/14.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#import "KVOBook.h"
#import <JGSourceBase/JGSourceBase.h>

@implementation KVOBook

- (void)setName:(NSString *)name {
    
    if ([self.name isEqualToString:name]) {
        return;
    }
    
    [self willChangeValueForKey:@"name"];
    [super setName:name];
    //[self didChangeValueForKey:@"name"];
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    
    //JGSCLog(@"%s : %@", __PRETTY_FUNCTION__, key);
    if ([key isEqualToString:@"name"]) {
        return NO;
    }
    
    return [super keyPathsForValuesAffectingValueForKey:key];
}

+ (BOOL)automaticallyNotifiesObserversOfName {
    
    // 禁止自动通知
    //JGSCLog(@"%s", __PRETTY_FUNCTION__);
    return YES;
}

+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    
    //JGSCLog(@"%s : %@", __PRETTY_FUNCTION__, key);
    if ([key isEqualToString:@"discount"]) {
        return [NSSet setWithObjects:@"price", nil];
    }
    
    return [super keyPathsForValuesAffectingValueForKey:key];
}

+ (NSSet *)keyPathsForValuesAffectingDiscount {
    //JGSCLog(@"%s", __PRETTY_FUNCTION__);
    return [NSSet setWithObjects:@"price", nil];
}

@end
