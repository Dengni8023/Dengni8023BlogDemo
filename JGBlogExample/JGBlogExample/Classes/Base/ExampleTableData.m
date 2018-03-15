//
//  ExampleTableData.m
//  JGBlogExample
//
//  Created by Mei Jigao on 2018/3/14.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#import "ExampleTableData.h"
#import <JGSourceBase/JGSourceBase.h>

@implementation ExampleTableRowInfo

#pragma mark - init & dealloc
- (instancetype)initWithTitle:(NSString *)title selector:(SEL)selector {
    
    self = [super init];
    if (self) {
        _title = title;
        _selector = selector;
    }
    return self;
}

- (void)dealloc {
    
    JGLog(@"<%@: %p>", NSStringFromClass([self class]), self);
}

#pragma mark - End

@end

@implementation ExampleTableSectionInfo

#pragma mark - init & dealloc
- (instancetype)initWithTitle:(NSString *)title rows:(NSArray<ExampleTableRowInfo *> *)rows {
    
    self = [super init];
    if (self) {
        _title = title;
        _rows = rows;
    }
    return self;
}

- (void)dealloc {
    
    JGLog(@"<%@: %p>", NSStringFromClass([self class]), self);
}

#pragma mark - End

@end

ExampleTableRowInfo *ExampleTableRowMake(NSString *title, SEL selector) {
    return [[ExampleTableRowInfo alloc] initWithTitle:title selector:selector];
}

ExampleTableSectionInfo *ExampleTableSectionMake(NSString *title, NSArray<ExampleTableRowInfo *> *rows) {
    return [[ExampleTableSectionInfo alloc] initWithTitle:title rows:rows];
}
