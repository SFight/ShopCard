//
//  VTSearchViewViewModel.h
//  VTShop
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VTDataSearchResults;

typedef void(^GoodsSearchCompletion)(VTDataSearchResults *dataSearchResults);

@interface VTSearchViewViewModel : NSObject

@property (nonatomic, strong) VTDataSearchResults *dataSearchResults;

- (void)queryGoodsWithName:(NSString *)name completion:(GoodsSearchCompletion)completion;

@end
