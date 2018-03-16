//
//  Person.m
//  JGBlogExample
//
//  Created by Mei Jigao on 2018/3/12.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#import "Person.h"
#import <JGSourceBase/JGSourceBase.h>

@interface Person ()

@property (nonatomic, copy, readonly) NSString *formatBirthdate; // 格式化生日字符串

@end

@implementation Person

#pragma mark - init & dealloc
- (instancetype)initWithName:(NSString *)name birthdate:(NSString *)birth {
    
    self = [super init];
    if (self) {
        
        self.name = name;
        _formatBirthdate = [self validDirthdateString:birth];
        _birthdate = [NSString stringWithFormat:@"%@-%@-%@", [self.formatBirthdate substringWithRange:NSMakeRange(0, 4)], [self.formatBirthdate substringWithRange:NSMakeRange(4, 2)], [self.formatBirthdate substringWithRange:NSMakeRange(6, 2)]];
        _idNumber = [self identifierNumberWithFormatBirthdate:_formatBirthdate];
    }
    return self;
}

- (void)dealloc {
    
    JGSCLog(@"<%@: %p>", NSStringFromClass([self class]), self);
}

#pragma mark - Data
- (NSString *)validDirthdateString:(NSString *)birth {
    
    NSString *format = nil;
    if ([[@(birth.integerValue) stringValue] isEqualToString:birth]) {
        
        // YYYYMMDD
        format = birth;
    }
    else if ([birth componentsSeparatedByString:@"-"].count == 3) {
        
        // YYYY-MM-DD
        format = [[birth componentsSeparatedByString:@"-"] componentsJoinedByString:@""];
    }
    else if ([birth componentsSeparatedByString:@"/"].count == 3) {
        
        // YYYY/MM/DD
        format = [[birth componentsSeparatedByString:@"/"] componentsJoinedByString:@""];
    }
    
    return format;
}

- (NSInteger)age {
    
    NSInteger year = [self.formatBirthdate substringWithRange:NSMakeRange(0, 4)].integerValue;
    NSInteger month = [self.formatBirthdate substringWithRange:NSMakeRange(4, 2)].integerValue;
    NSInteger day = [self.formatBirthdate substringWithRange:NSMakeRange(6, 2)].integerValue;
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:now];
    NSInteger nowMonth = [calendar component:NSCalendarUnitMonth fromDate:now];
    NSInteger nowDay = [calendar component:NSCalendarUnitDay fromDate:now];
    
    NSInteger age = nowYear - year;
    if (nowMonth > month) {
        age += 1;
    }
    else if (nowMonth == month && nowDay > day) {
        age += 1;
    }
    
    return age;
}

- (NSString *)identifierNumberWithFormatBirthdate:(NSString *)birth {
    
    NSMutableString *identifier = [@(arc4random() % 10 + 1) stringValue].mutableCopy;
    [identifier appendFormat:@"%05ud", arc4random() % 100000];
    
    [identifier appendString:birth];
    [identifier appendFormat:@"%04ud", arc4random() % 10000];
    
    return identifier.copy;
}

#pragma mark - End

@end
