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

typedef NS_ENUM(NSInteger, VTShopCardTableViewCellStyle) {
    VTShopCardTableViewCellStyleDefault, // 默认没有圈
    VTShopCardTableViewCellStyleSelection // 有选中圈
};

@interface VTShopCardTableViewCell : UITableViewCell

- (instancetype)initWithFrame:(CGRect)frame style:(VTShopCardTableViewCellStyle)style resuseIdentifier:(NSString *)reuseIdentifier;

- (void)setCellIndexPath:(NSIndexPath *)indexPath;

- (void)setDataModel:(VTDataShopCard *)dataShopCard;

- (void)setCellOnDataChange:(OnDataChange)onDataChange;

@end
