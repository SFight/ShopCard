//
//  VTShopCardTableViewControl.m
//  VTShop
//
//  Created by vtears on 2018/6/29.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import "VTShopCardTableViewControl.h"

#import "VTShopCardTableViewCell.h"

#import "VTDataShopCard.h"
#import "VTDataSearchResults.h"
#import "VTSearchViewViewModel.h"

extern NSString *const kShopCardTableViewCell;

@interface VTShopCardTableViewControl()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) VTSearchViewViewModel *searchViewViewModel;
@property (nonatomic, strong) VTDataSearchResults *dataSearchResults;

@end

@implementation VTShopCardTableViewControl

- (instancetype)initWithTableView:(UITableView *)tableView viewModel:(VTSearchViewViewModel *)searchViewViewModel
{
    self = [super init];
    if (self) {
        _tableView = tableView;
        _searchViewViewModel = searchViewViewModel;
        //        [self.tableView registerClass:[VTShopCardTableViewCell class] forCellReuseIdentifier:kShopCardTableViewCell];
    }
    
    return self;
}

#pragma mark - 设置数据源
- (void)setDataModel:(VTDataSearchResults *)dataSearchResults
{
    _dataSearchResults = dataSearchResults;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSearchResults.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VTShopCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kShopCardTableViewCell];
    
    if (cell == nil) {
        cell = [[VTShopCardTableViewCell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 96) style:VTShopCardTableViewCellStyleSelection resuseIdentifier:kShopCardTableViewCell];
    }
    
    [cell setCellIndexPath:indexPath];
    VTDataShopCard *dataShopCard = [self.dataSearchResults.dataArray objectAtIndex:indexPath.row];
    [cell setDataModel:dataShopCard];
    
    __weak typeof(self) weakSelf = self;
    [cell setCellOnDataChange:^(VTDataShopCard *dataShopCard, NSIndexPath *indexPath) {
        [weakSelf.dataSearchResults.dataArray replaceObjectAtIndex:indexPath.row withObject:dataShopCard];
        [weakSelf.dataSearchResults reload];
        weakSelf.searchViewViewModel.dataSearchResults = weakSelf.dataSearchResults;
    }];
    
    return cell;
}

@end
