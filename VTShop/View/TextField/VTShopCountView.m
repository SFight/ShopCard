//
//  VTShopCountView.m
//  VTShop
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import "VTShopCountView.h"

NSString *const kMinusName = @"vt_minus";
NSString *const kAddName = @"vt_add";

@interface VTShopCountView()

@end

@implementation VTShopCountView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        minusButton.frame = CGRectMake(0, 0, frame.size.height, frame.size.height);
        [minusButton setImage:[UIImage imageNamed:kMinusName inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [minusButton addTarget:self action:@selector(onClickMinusButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(0, 0, frame.size.height, frame.size.height);
        [addButton setImage:[UIImage imageNamed:kAddName inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(onClickAddButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.leftView = minusButton;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.rightView = addButton;
        self.rightViewMode = UITextFieldViewModeAlways;
        self.textAlignment = NSTextAlignmentCenter;
        
        self.text = @"1";
        
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return self;
}

#pragma mark - SEL
- (void)onClickMinusButton:(UIButton *)button
{
    NSInteger num = [self.text integerValue] - 1;
//    if (num <= 0) {
//        if (self.onShopCardDelete) {
//            self.onShopCardDelete();
//        }
//        return;
//    }
    self.text = [NSString stringWithFormat:@"%zi", num];
    if (self.onShopCardMinusOne) {
        self.onShopCardMinusOne();
    }
}

- (void)onClickAddButton:(UIButton *)button
{
    NSInteger num = [self.text integerValue] + 1;
    self.text = [NSString stringWithFormat:@"%zi", num];
    
    if (self.onShopCardAddOne) {
        self.onShopCardAddOne();
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    
}

@end
