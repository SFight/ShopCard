//
//  VTShopCountView.h
//  VTShop
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OnShopCardDelete)(void);
typedef void(^OnShopCardMinusOne)(void);
typedef void(^OnShopCardAddOne)(void);

@interface VTShopCountView : UITextField

@property (nonatomic, copy) OnShopCardDelete onShopCardDelete;
@property (nonatomic, copy) OnShopCardAddOne onShopCardAddOne;
@property (nonatomic, copy) OnShopCardMinusOne onShopCardMinusOne;

@end
