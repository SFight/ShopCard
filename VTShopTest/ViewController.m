//
//  ViewController.m
//  VTShopTest
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import "ViewController.h"

#import <VTShop/VTShop.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SEL
- (IBAction)onClickButton:(UIButton *)button
{
    VTSearchViewController *searchVC = [[VTSearchViewController alloc] initWithNibName:NSStringFromClass([VTSearchViewController class]) bundle:[NSBundle bundleForClass:[VTSearchViewController class]]];
    [self presentViewController:searchVC animated:YES completion:nil];
}


@end
