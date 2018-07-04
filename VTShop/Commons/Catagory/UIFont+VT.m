//
//  UIFont+VT.m
//  VTShop
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import "UIFont+VT.h"

@implementation UIFont (VT)

+ (UIFont *)fontWithSize:(CGFloat)fontSize
{
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)boldFontWithSize:(CGFloat)fontSize
{
    return [UIFont boldSystemFontOfSize:fontSize];
}

@end
