//
//  VTSearchViewController.m
//  VTShop
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import "VTSearchViewController.h"

#import "VTSearchTableViewController.h"

#import "VTSearchViewViewModel.h"
#import "VTDataSearchResults.h"

@interface VTSearchViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *cancelSearch;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic, strong) VTSearchTableViewController *tableViewControl;
@property (nonatomic, strong) VTSearchViewViewModel *searchViewViewModel;

@end

@implementation VTSearchViewController

#pragma mark - lazyInit
- (VTSearchTableViewController *)tableViewControl
{
    if (!_tableViewControl) {
        _tableViewControl = [[VTSearchTableViewController alloc] initWithTableView:self.tableView viewModel:self.searchViewViewModel];
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
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self.tableViewControl;
    self.tableView.dataSource = self.tableViewControl;
    [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [self.searchViewViewModel addObserver:self forKeyPath:@"dataSearchResults" options:NSKeyValueObservingOptionNew context:nil];
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
- (IBAction)onClickBackButton:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onClickCancelSearchButton:(UIButton *)button
{
    [self.searchTextField resignFirstResponder];
    self.cancelSearch.hidden = YES;
}

- (IBAction)onClickShopButton:(UIButton *)button
{
    
}

- (IBAction)onClickPayButton:(UIButton *)button
{
    
}

#pragma mark - SEL
- (void)textFieldDidChange:(UITextField *)textField
{
    // 开始查询
    __weak typeof(self) weakSelf = self;
    [self.searchViewViewModel queryGoodsWithName:textField.text completion:^(VTDataSearchResults *dataSearchResults) {
        [weakSelf.tableViewControl setDataModel:dataSearchResults];
        [weakSelf.tableView reloadData];
        weakSelf.priceLabel.text = dataSearchResults.totalBuyPriceDiscription;
        
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.cancelSearch.hidden = NO;
}

@end
