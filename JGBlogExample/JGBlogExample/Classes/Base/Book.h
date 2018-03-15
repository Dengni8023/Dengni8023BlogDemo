//
//  Book.h
//  JGBlogExample
//
//  Created by Mei Jigao on 2018/3/14.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject

@property (nonatomic, copy) NSString *name; // 书名
@property (nonatomic, copy) NSString *publishName; // 出版社

@property (nonatomic, assign, readonly) NSInteger originPrice; // 原价，分
@property (nonatomic, assign) NSInteger price; // 售价，分
@property (nonatomic, assign, readonly) CGFloat discount; // 折扣，由原价、售价共同确定

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithName:(NSString *)name originPrice:(NSInteger)oriP publish:(NSString *)publish;

@end

NS_ASSUME_NONNULL_END
