//
//  Company.h
//  JGBlogExample
//
//  Created by Mei Jigao on 2018/3/12.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Company : NSObject

@property (nonatomic, copy) NSString *name; // 公司名称
@property (nonatomic, copy) NSString *telphone; // 公司电话

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithName:(NSString *)name tel:(NSString *)phoneNo;

@end

NS_ASSUME_NONNULL_END
