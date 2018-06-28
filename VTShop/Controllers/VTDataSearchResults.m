//
//  VTDataSearchResults.m
//  VTShop
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import "VTDataSearchResults.h"

#import "VTDataShopCard.h"

@implementation VTDataSearchResults

- (instancetype)initWithShopCards:(NSArray<VTDataShopCard *> *)dataArray
{
    self = [super init];
    if (self) {
        _dataArray = [NSMutableArray arrayWithArray:dataArray];
        double price = 0.0f;
        for (VTDataShopCard *dataShopCard in dataArray) {
            price += [dataShopCard.price doubleValue] * [dataShopCard.buyCount integerValue];
        }
        
        _totalBuyPrice = [NSNumber numberWithDouble:price];
        _totalBuyPriceDiscription = [NSString stringWithFormat:@"¥%.2f", price];
    }
    
    return self;
}

- (void)reload
{
    double price = 0.0f;
    for (VTDataShopCard *dataShopCard in self.dataArray) {
        price += [dataShopCard.price doubleValue] * [dataShopCard.buyCount integerValue];
    }
    
    _totalBuyPrice = [NSNumber numberWithDouble:price];
    _totalBuyPriceDiscription = [NSString stringWithFormat:@"¥%.2f", price];
}

@end
