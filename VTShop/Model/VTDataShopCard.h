//
//  VTDataShopCard.h
//  VTShop
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import "VTDataBase.h"

typedef NS_ENUM(NSInteger, ShopCardState) {
    ShopCardStateDefault, // 默认状态
    ShopCardStateSelection, // 选中状态
    ShopCardStateDisabled // 不可用状态
};

@interface VTDataShopCard : VTDataBase

@property (nonatomic, copy, readonly) NSString *imagePath;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *priceDiscription;
@property (nonatomic, copy, readonly) NSNumber *price;
@property (nonatomic, copy) NSNumber *buyCount;
@property (nonatomic, assign) ShopCardState state;
@property (nonatomic, copy, readonly) NSString *discription;

@end
