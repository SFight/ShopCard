//
//  VTShopCardTableViewControl.h
//  VTShop
//
//  Created by vtears on 2018/6/29.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VTDataSearchResults;
@class VTSearchViewViewModel;

@interface VTShopCardTableViewControl : NSObject<UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithTableView:(UITableView *)tableView viewModel:(VTSearchViewViewModel *)searchViewViewModel;

- (void)setDataModel:(VTDataSearchResults *)dataSearchResults;

@end
