//
//  VTDataSearchResults.h
//  VTShop
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VTDataShopCard;

@interface VTDataSearchResults : NSObject

@property (nonatomic, copy) NSMutableArray<VTDataShopCard *> *dataArray;
@property (nonatomic, copy, readonly) NSString *totalBuyPriceDiscription;
@property (nonatomic, copy, readonly) NSNumber *totalBuyPrice;

- (instancetype)initWithShopCards:(NSArray<VTDataShopCard *> *)dataArray;

/**
  * 重新计算
  */
- (void)reload;

@end
