//
//  KVCPerson.m
//  JGBlogExample
//
//  Created by Mei Jigao on 2018/3/12.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#import "KVCPerson.h"
#import <JGSourceBase/JGSourceBase.h>

@interface KVCPerson () {
    
    NSString *nameSaveString;
    NSArray<NSString *> *interestSaveArray;
    NSSet<NSString *> *interestSaveSet;
    
    // Set键值搜索顺序
    NSString *_nameSetString;
    NSString *_isNameSetString;
    NSString *nameSetString;
    NSString *isNameSetString;
    
    // Get键值搜索顺序
    id _interestCollect;
    id _isInterestCollect;
    id interestCollect;
    id isInterestCollect;
}

@end

@implementation KVCPerson

+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}

#pragma mark - Getter & Setter
- (void)setName:(NSString *)name {
    [super setName:name];
    
    nameSaveString = [NSString stringWithFormat:@"%@-Save", name];
}

- (void)setInterest:(NSArray<NSString *> *)interest {
    [super setInterest:interest];
    
    interestSaveArray = interest.copy;
    
    NSMutableSet *tmp = [NSMutableSet set];
    [interest enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tmp addObject:obj];
    }];
    interestSaveSet = tmp.copy;
    
    _interestCollect = @"_interestCollect";
    _isInterestCollect = @"_isInterestCollect";
    interestCollect = @"interestCollect";
    isInterestCollect = @"isInterestCollect";
}

#pragma mark - KVC
- (id)valueForKey:(NSString *)key {
    
    id value = [super valueForKey:key];
    if ([key isEqualToString:@"interestCollect"]) {
        
        JGLog(@"KVC get search : %@"
              "\n_interestCollect : %@"
              "\n_isInterestCollect : %@"
              "\ninterestCollect : %@"
              "\nisInterestCollect : %@",
              key,
              _interestCollect,
              _isInterestCollect,
              interestCollect,
              isInterestCollect
              );
    }
    
    return value;
}

- (id)valueForUndefinedKey:(NSString *)key {
    
    JGLog(@"默认实现是抛出异常，重写以做错误处理 => %@", key);
    return nil;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    NSError *error = nil;
    if (![self validateValue:&value forKey:key error:&error]) {
        JGLog(@"验证失败 ： %@", error);
        return;
    }
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"nameSetString"]) {
        
        JGLog(@"KVC set search : %@"
              "\n_nameSetString : %@"
              "\n_isNameSetString : %@"
              "\nnameSetString : %@"
              "\nisNameSetString : %@",
              key,
              _nameSetString,
              _isNameSetString,
              nameSetString,
              isNameSetString
              );
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    JGLog(@"默认实现是抛出异常，重写以做错误处理 => <%@ : %@>", key, value);
}

- (void)setNilValueForKey:(NSString *)key {
    
    JGLog(@"默认实现是抛出异常，重写以做错误处理 => %@", key);
}

#pragma mark - KVV
- (BOOL)validateName:(inout NSString * _Nullable __autoreleasing *)ioValue error:(out NSError * _Nullable __autoreleasing *)outError {
    
    JGLog(@"KVV验证 Name，必须有“KVC-”前缀");
    if ([*ioValue hasPrefix:@"KVC-"]) {
        return YES;
    }

    return NO;
}

// 在多个Key都需要自定义限制逻辑时需要针对不同Key实现多个Key的限制逻辑接口
// 可以将该逻辑放到以下接口中进行，除了需要自定义限制逻辑的Key，其他的使用 [super validateValue:ioValue forKey:inKey error:outError]即可处理
- (BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKey:(NSString *)inKey error:(out NSError * _Nullable __autoreleasing *)outError {
    
    /*
     系统默认实现为：查找是否实现针对inKey的 validateKey:error: 方法，如有则返回该方法的返回值，否则直接返回YES
     validateKey:error:方法需要针对每个Key实现对应的方法，可以见验证逻辑统一放到本方法内部进行
     */
    
    JGLog(@"KVV验证 %@", inKey);
    BOOL ret = YES;
    if ([inKey isEqualToString:@"name"]) {
        
        JGLog(@"%@ 必须有“KVC-”前缀", inKey);
        NSString *name = (NSString *)(*ioValue);
        ret = [name hasPrefix:@"KVC-"];
        if (!ret) {
            *outError = [NSError errorWithDomain:NSMachErrorDomain code:-1 userInfo:@{@"Description" : [NSString stringWithFormat:@"%@ 必须有“KVC-”前缀", inKey]}];
        }
    }
    // 其他key的自定义验证逻辑
    else {
        
        // 系统默认实现的返回值
        ret = [super validateValue:ioValue forKey:inKey error:outError];
    }
    
    return ret;
}

#pragma mark - KVC Set Search
- (void)setNameSetString:(NSString *)name {
    
    // 测试简直搜索响应顺序 - 1
    JGLog(@"KVC set nameSetString");
    nameSaveString = name.copy;
}

#pragma mark - KVC Get Search
- (id)getInterestCollect {

    // 测试简直搜索响应顺序 - 1
    JGLog(@"KVC get interestCollect");
    return interestSaveArray;
    //return interestSaveSet;
}

- (id)interestCollect {

    // 测试简直搜索响应顺序 - 2
    JGLog(@"KVC get interestCollect");
    return interestSaveArray;
    //return interestSaveSet;
}

- (id)isInterestCollect {

    // 测试简直搜索响应顺序 - 3
    JGLog(@"KVC get interestCollect");
    return interestSaveArray;
    //return interestSaveSet;
}

- (id)_interestCollect {

    // 测试简直搜索响应顺序 - 4
    JGLog(@"KVC get interestCollect");
    return interestSaveArray;
    //return interestSaveSet;
}

#pragma mark - KVC Get Search Interest Collect
/*
 声明属性时，系统默认将添加默认成员变量定义，此时以下方法将不执行，直接返回外部设置的属性值
 若要使以下方法生效
 1）不声明属性 interestCollect
 2）不使用成员变量 _interestCollect, _isInterestCollect, interestCollect, isInterestCollect
 */
- (NSInteger)countOfInterestCollect {
    return interestSaveArray.count;
}

#pragma mark - KVC Get Search Interest Collect Array
// 优先级高于 interestArrayAtIndexes:
- (NSString *)objectInInterestCollectAtIndex:(NSUInteger)index {
    return [interestSaveArray objectAtIndex:index];
}

// 优先级低于 objectInInterestArrayAtIndex:
- (NSArray *)interestCollectAtIndexes:(NSIndexSet *)indexes {
    return [interestSaveArray objectsAtIndexes:indexes];
}

/**
 若重写以下方法
 则 objectInInterestCollectAtIndex: 和 interestCollectAtIndexes: 内部实现无效
 但是其中之一必需实现
 */
//- (void)getInterestCollect:(NSString * __unsafe_unretained *)buffer range:(NSRange)inRange {
//    [interestSaveArray getObjects:buffer range:inRange];
//}

#pragma mark - KVC Get Search Interest Collect Set
- (NSEnumerator *)enumeratorOfInterestCollect {
    return [interestSaveSet objectEnumerator];
}

- (NSString *)memberOfInterestCollect:(NSString *)object {
    return [interestSaveSet member:object];
}

@end
