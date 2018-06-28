//
//  VTDataBase.h
//  VTShop
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VTDataBase : NSObject

@property (nonatomic, copy, readonly) NSDictionary *responseDic;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

- (NSString *)stringValue:(id)value;

- (NSNumber *)numberValue:(id)value;

@end
