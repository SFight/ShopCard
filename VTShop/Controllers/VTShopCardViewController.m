//
//  VTShopCardViewController.m
//  VTShop
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import "VTShopCardViewController.h"

#import "VTShopCardTableViewControl.h"
#import "VTSearchViewViewModel.h"

#import "VTDataSearchResults.h"
#import "VTDataShopCard.h"

@interface VTShopCardViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *yxLabel; // 已选x件 标志
@property (weak, nonatomic) IBOutlet UILabel *priceLabel; // 价格

@property (weak, nonatomic) IBOutlet UIImageView *checkAllImageView;
@property (weak, nonatomic) IBOutlet UIButton *checkAllButton;

@property (nonatomic, strong) VTShopCardTableViewControl *tableViewControl;
@property (nonatomic, strong) VTSearchViewViewModel *searchViewViewModel;


@end

@implementation VTShopCardViewController

#pragma mark - lazyInit
- (VTShopCardTableViewControl *)tableViewControl
{
    if (!_tableViewControl) {
        _tableViewControl = [[VTShopCardTableViewControl alloc] initWithTableView:self.tableView viewModel:self.searchViewViewModel];
    }
    
    return _tableViewControl;
}

- (VTSearchViewViewModel *)searchViewViewModel
{
    if (!_searchViewViewModel) {
        _searchViewViewModel = [[VTSearchViewViewModel alloc] init];
    }
    
    return _searchViewViewModel;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self.tableViewControl;
    self.tableView.dataSource = self.tableViewControl;
    
    [self.searchViewViewModel addObserver:self forKeyPath:@"dataSearchResults" options:NSKeyValueObservingOptionNew context:nil];
    
    // 开始查询
    __weak typeof(self) weakSelf = self;
    [self.searchViewViewModel queryGoodsWithName:@"" completion:^(VTDataSearchResults *dataSearchResults) {
        weakSelf.searchViewViewModel.dataSearchResults = dataSearchResults;
//        [weakSelf.tableViewControl setDataModel:dataSearchResults];
//        [weakSelf.tableView reloadData];
//        weakSelf.priceLabel.text = dataSearchResults.totalBuyPriceDiscription;
        
    }];
}

- (void)dealloc
{
    [self.searchViewViewModel removeObserver:self forKeyPath:@"dataSearchResults"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - override
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([@"dataSearchResults" isEqualToString:keyPath]) {
        [self.tableViewControl setDataModel:self.searchViewViewModel.dataSearchResults];
        [self.tableView reloadData];
        self.priceLabel.text = self.searchViewViewModel.dataSearchResults.totalBuyPriceDiscription;
    }
}

#pragma mark - IBAction
- (IBAction)onClickShopButton:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onClickCheckAllButton:(UIButton *)button
{
    button.selected = !button.selected;
    self.checkAllImageView.highlighted = button.selected;
    
    for (VTDataShopCard *dataShopCard in self.searchViewViewModel.dataSearchResults.dataArray) {
        dataShopCard.state = dataShopCard.state == ShopCardStateDisabled ? ShopCardStateDisabled : button.selected ? ShopCardStateSelection : ShopCardStateDefault;
    }
    
    VTDataSearchResults *dataSearchResults = [[VTDataSearchResults alloc] initWithShopCards:self.searchViewViewModel.dataSearchResults.dataArray];
    [dataSearchResults reload];
    self.searchViewViewModel.dataSearchResults = dataSearchResults;
    
}

- (IBAction)onClickClearAllButton:(UIButton *)button
{
    self.checkAllButton.selected = NO;
    self.checkAllImageView.highlighted = NO;
    
    [self.searchViewViewModel.dataSearchResults.dataArray removeAllObjects];
    self.searchViewViewModel.dataSearchResults = nil;
    
    VTDataSearchResults *dataSearchResults = [[VTDataSearchResults alloc] initWithShopCards:self.searchViewViewModel.dataSearchResults.dataArray];
    [dataSearchResults reload];
    self.searchViewViewModel.dataSearchResults = dataSearchResults;
}

- (IBAction)onClickPayButton:(UIButton *)button
{
    
}

@end
