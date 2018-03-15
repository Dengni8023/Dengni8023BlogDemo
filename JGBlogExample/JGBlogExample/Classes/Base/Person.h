//
//  Person.h
//  JGBlogExample
//
//  Created by Mei Jigao on 2018/3/12.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, copy) NSString *name; // 姓名
@property (nonatomic, copy, readonly) NSString *birthdate; // 出生日期 形如YYYYMMDD
@property (nonatomic, assign, readonly) NSInteger age; // 年龄
@property (nonatomic, copy, readonly) NSString *idNumber; // 唯一识别码

@property (nonatomic, strong, nullable) Company *company; // 公司

@property (nonatomic, strong, nullable) NSArray<NSString *> *interest; // 兴趣
@property (nonatomic, strong, nullable) NSSet<Book *> *ownedBooks; // 拥有书籍

- (instancetype)init NS_UNAVAILABLE;

/** 出生日期格式YYYY-MM-DD YYYY/MM/DD YYYYMMDD */
- (instancetype)initWithName:(NSString *)name birthdate:(NSString *)birth;

@end

NS_ASSUME_NONNULL_END
