//
//  VTSearchTableViewController.h
//  VTShop
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VTDataSearchResults;
@class VTSearchViewViewModel;

@interface VTSearchTableViewController : NSObject<UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithTableView:(UITableView *)tableView viewModel:(VTSearchViewViewModel *)searchViewViewModel;

- (void)setDataModel:(VTDataSearchResults *)dataSearchResults;

@end
