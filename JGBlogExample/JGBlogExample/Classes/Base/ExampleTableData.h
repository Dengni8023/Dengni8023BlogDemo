//
//  ExampleTableData.h
//  JGBlogExample
//
//  Created by Mei Jigao on 2018/3/14.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExampleTableRowInfo : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) SEL selector;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTitle:(NSString *)title selector:(SEL)selector;

@end

@interface ExampleTableSectionInfo : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray<ExampleTableRowInfo *> *rows;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTitle:(NSString *)title rows:(NSArray<ExampleTableRowInfo *> *)rows;

@end

FOUNDATION_EXTERN ExampleTableRowInfo *ExampleTableRowMake(NSString *title, SEL selector);
FOUNDATION_EXTERN ExampleTableSectionInfo *ExampleTableSectionMake(NSString *title, NSArray<ExampleTableRowInfo *> *rows);

NS_ASSUME_NONNULL_END
