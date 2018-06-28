//
//  VTDataShopCard.m
//  VTShop
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import "VTDataShopCard.h"

NSString *const kShopCardImagePath = @"image_path";
NSString *const kShopCardTitle = @"title";
NSString *const kShopCardPriceDiscription = @"price_discription";
NSString *const kShopCardPrice = @"price";
NSString *const kShopCardBuyCount = @"buy_count";

@implementation VTDataShopCard

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super initWithDictionary:dic];
    if (self) {
        _imagePath = [self stringValue:self.responseDic[kShopCardImagePath]];
        _title = [self stringValue:self.responseDic[kShopCardTitle]];
        _priceDiscription = [self stringValue:self.responseDic[kShopCardPriceDiscription]];
        _price = [self numberValue:self.responseDic[kShopCardPrice]];
        _buyCount = [self numberValue:self.responseDic[kShopCardBuyCount]];
    }
    
    return self;
}

@end
