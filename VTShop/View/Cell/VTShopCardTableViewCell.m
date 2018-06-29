//
//  VTShopCardTableViewCell.m
//  VTShop
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import "VTShopCardTableViewCell.h"

#import "VTShopCountView.h"

#import "VTDataShopCard.h"

#define kFontSize_12_5          12.5        // 12.5号字体
#define kFontSize_14            14      // 14号字体
#define kFontSize_15            15      // 15号字体

extern NSString *const kAddName;
NSString *const kSelectionN = @"vt_shop_N"; // 按钮普通状态
NSString *const kSelectionH = @"vt_shop_H"; // 按钮选中状态
NSString *const kSelectionG = @"vt_shop_G"; // 按钮不可选状态


@interface VTShopCardTableViewCell()

@property (nonatomic, strong) UIButton *selectionButton; // 选中按钮
@property (nonatomic, strong) UIImageView *goodsImageView; // 商品图标
@property (nonatomic, strong) UILabel *goodsTitleLabel; // 商品标题
@property (nonatomic, strong) UILabel *goodsPriceLabel; // 商品价格
@property (nonatomic, strong) UIButton *addButton; // 添加商品按钮
@property (nonatomic, strong) VTShopCountView *shopCountView; // 添加、减少框
@property (nonatomic, strong) UILabel *goodsInfoLabel; // 商品不足的提示信息
@property (nonatomic, strong) UIView *lineView; // 底部分割线

@property (nonatomic, strong) VTDataShopCard *dataShopCard;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) OnDataChange onDataChange;

@end

@implementation VTShopCardTableViewCell

#pragma mark - lazyInit
- (UIButton *)selectionButton
{
    if (!_selectionButton) {
        _selectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectionButton setImage:[UIImage imageNamed:kSelectionN inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [_selectionButton setImage:[UIImage imageNamed:kSelectionH inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateSelected];
        [_selectionButton setImage:[UIImage imageNamed:kSelectionG inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateDisabled];
        
        [_selectionButton addTarget:self action:@selector(onClickSelectionButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _selectionButton;
}
- (UIImageView *)goodsImageView
{
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 56, 54)];
        [_goodsImageView setImage:[UIImage imageNamed:@"vt_goods" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil]];
    }
    
    return _goodsImageView;
}

- (UILabel *)goodsTitleLabel
{
    if (!_goodsTitleLabel) {
        _goodsTitleLabel = [[UILabel alloc] init];
        _goodsTitleLabel.font = [UIFont fontWithSize:kFontSize_14];
        _goodsTitleLabel.textColor = [UIColor colorForHex:@"#333333"];
        _goodsTitleLabel.numberOfLines = 2;
        _goodsTitleLabel.text = @"西班牙原瓶进口卡谛娅干红葡萄酒，2支精装版。（6瓶装）";
    }
    
    return _goodsTitleLabel;
}

- (UILabel *)goodsPriceLabel
{
    if (!_goodsPriceLabel) {
        _goodsPriceLabel = [[UILabel alloc] init];
        _goodsPriceLabel.font = [UIFont boldFontWithSize:kFontSize_12_5];
        _goodsPriceLabel.textColor = [UIColor colorForHex:@"#fb3244"];
        _goodsPriceLabel.text = @"￥49.00";
    }
    
    return _goodsPriceLabel;
}

- (UIButton *)addButton
{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame = CGRectMake(0, 0, 25, 25);
        [_addButton setImage:[UIImage imageNamed:kAddName inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(onClickAddButton:) forControlEvents:UIControlEventTouchUpInside];
        _addButton.hidden = YES;
    }
    
    return _addButton;
}

- (VTShopCountView *)shopCountView
{
    if (!_shopCountView) {
        _shopCountView = [[VTShopCountView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        _shopCountView.hidden = YES;
        
        __weak typeof(self) weakSelf = self;
        _shopCountView.onShopCardDelete = ^{
            weakSelf.shopCountView.hidden = YES;
            weakSelf.addButton.hidden = NO;
        };
        
        _shopCountView.onShopCardMinusOne = ^{
            weakSelf.dataShopCard.buyCount = [NSNumber numberWithInteger:[weakSelf.dataShopCard.buyCount integerValue] - 1];
            if (weakSelf.onDataChange) {
                weakSelf.onDataChange(weakSelf.dataShopCard, weakSelf.indexPath);
            }
        };
        
        _shopCountView.onShopCardAddOne = ^{
            weakSelf.dataShopCard.buyCount = [NSNumber numberWithInteger:[weakSelf.dataShopCard.buyCount integerValue] + 1];
            if (weakSelf.onDataChange) {
                weakSelf.onDataChange(weakSelf.dataShopCard, weakSelf.indexPath);
            }
        };
    }
    
    return _shopCountView;
}

- (UILabel *)goodsInfoLabel
{
    if (!_goodsInfoLabel) {
        _goodsInfoLabel = [[UILabel alloc] init];
        _goodsInfoLabel.font = [UIFont fontWithSize:kFontSize_15];
        _goodsInfoLabel.textColor = [UIColor colorForHex:@"#333333"];
        _goodsInfoLabel.text = @"商品库存不足";
        _goodsInfoLabel.hidden = YES;
    }
    
    return _goodsInfoLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
        _lineView.backgroundColor = [UIColor colorForHex:@"#ededed"];
    }
    
    return _lineView;
}

#pragma mark - inilization
- (instancetype)initWithFrame:(CGRect)frame style:(VTShopCardTableViewCellStyle)style resuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = frame;
        
        [self setupSubviews:style];
        [self constraintsSubviews:style];
    }
    
    return self;
}

- (void)setupSubviews:(VTShopCardTableViewCellStyle)style
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (style == VTShopCardTableViewCellStyleSelection) {
        [self.contentView addSubview:self.selectionButton];
    }
    [self.contentView addSubview:self.goodsImageView];
    [self.contentView addSubview:self.goodsTitleLabel];
    [self.contentView addSubview:self.goodsPriceLabel];
    [self.contentView addSubview:self.addButton];
    [self.contentView addSubview:self.shopCountView];
    [self.contentView addSubview:self.goodsInfoLabel];
    [self.contentView addSubview:self.lineView];
}

- (void)constraintsSubviews:(VTShopCardTableViewCellStyle)style
{
    __weak typeof(self) weakSelf = self;
    
    if (style == VTShopCardTableViewCellStyleSelection) {
        [self.selectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(19);
            make.left.equalTo(weakSelf.contentView.mas_left).with.offset(15);
            make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        }];
    }
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).with.offset(22);
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(style == VTShopCardTableViewCellStyleSelection ? 43 : 20);
        make.width.mas_equalTo(56);
        make.height.mas_equalTo(54);
    }];
    
    [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).with.offset(15);
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(style == VTShopCardTableViewCellStyleSelection ? 106 : 93);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-15);
    }];
    
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goodsTitleLabel.mas_left);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).with.offset(-15);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(25);
        make.right.equalTo(weakSelf.mas_right).with.offset(-15);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-15);
    }];
    
    [self.shopCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(80);
        make.right.equalTo(weakSelf.mas_right).with.offset(-15);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-15);
    }];
    
    [self.goodsInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-15);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-15);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(15);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-15);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
    }];
    
}

#pragma mark - 初始化视图
- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    for (UIView *aView in [self.contentView subviews]) {
//        [aView removeFromSuperview];
//    }
//    
//    [self setupSubviews];
//    [self constraintsSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - SEL
- (void)onClickSelectionButton:(UIButton *)button
{
    button.selected = !button.selected;
    self.dataShopCard.state = button.selected ? ShopCardStateSelection : ShopCardStateDefault;
    
    if (self.onDataChange) {
        self.onDataChange(self.dataShopCard, self.indexPath);
    }
}

- (void)onClickAddButton:(UIButton *)button
{
    self.shopCountView.hidden = NO;
    self.dataShopCard.state = ShopCardStateSelection;
    self.dataShopCard.buyCount = @1;
    if (self.onDataChange) {
        self.onDataChange(self.dataShopCard, self.indexPath);
    }
}

#pragma mark - 设置数据源
- (void)setDataModel:(VTDataShopCard *)dataShopCard
{
    _dataShopCard = dataShopCard;
    [self updateView];
}

#pragma mark - 更新数据
- (void)updateView
{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.goodsImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.dataShopCard.imagePath]] scale:1.0f]];
    }];
//    [self.goodsImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.dataShopCard.imagePath]] scale:1.0f]];
    self.goodsTitleLabel.text = self.dataShopCard.title;
    self.goodsPriceLabel.text = self.dataShopCard.priceDiscription;
    if (self.dataShopCard.state == ShopCardStateDisabled) {
        self.selectionButton.enabled = NO;
        self.contentView.backgroundColor = [UIColor colorForHex:@"#ededed"];
        self.goodsInfoLabel.hidden = NO;
        self.addButton.hidden = YES;
        self.shopCountView.hidden = YES;
        self.goodsInfoLabel.text = self.dataShopCard.discription;
    } else {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionButton.enabled = YES;
        self.selectionButton.selected = self.dataShopCard.state;
        
        if ([self.dataShopCard.buyCount integerValue] > 0) {
            self.shopCountView.hidden = NO;
            self.addButton.hidden = YES;
            self.goodsInfoLabel.hidden = YES;
            
            self.shopCountView.text = [NSString stringWithFormat:@"%@", self.dataShopCard.buyCount];
        } else {
            self.addButton.hidden = NO;
            self.shopCountView.hidden = YES;
            self.goodsInfoLabel.hidden = YES;
        }
    }
    
}

#pragma mark - 设置cell的位置
- (void)setCellIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
}

#pragma mark - 设置数据源变动的回调
- (void)setCellOnDataChange:(OnDataChange)onDataChange
{
    _onDataChange = onDataChange;
}

@end
