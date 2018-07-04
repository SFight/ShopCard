//
//  VTDataBase.m
//  VTShop
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import "VTDataBase.h"

@implementation VTDataBase

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _responseDic = dic;
    }
    
    return self;
}

- (NSString *)stringValue:(id)value
{
    return [NSString stringWithFormat:@"%@", value];
}

- (NSNumber *)numberValue:(id)value
{
    return [NSNumber numberWithDouble:[[NSString stringWithFormat:@"%@", value] doubleValue]];
}

@end
