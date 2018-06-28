//
//  VTShopCardTableViewCell.h
//  VTShop
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VTDataShopCard;

typedef void(^OnDataChange)(VTDataShopCard *dataShopCard, NSIndexPath *indexPath);
@interface VTShopCardTableViewCell : UITableViewCell

- (instancetype)initWithFrame:(CGRect)frame resuseIdentifier:(NSString *)reuseIdentifier;

- (void)setCellIndexPath:(NSIndexPath *)indexPath;

- (void)setDataModel:(VTDataShopCard *)dataShopCard;

- (void)setCellOnDataChange:(OnDataChange)onDataChange;

@end
