//
//  VTSearchViewViewModel.m
//  VTShop
//
//  Created by vtears on 2018/6/28.
//  Copyright © 2018年 vtears.com. All rights reserved.
//

#import "VTSearchViewViewModel.h"

#import "VTDataSearchResults.h"
#import "VTDataShopCard.h"

@implementation VTSearchViewViewModel

- (void)queryGoodsWithName:(NSString *)name completion:(GoodsSearchCompletion)completion
{
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"shopsearch" ofType:@"plist"];
    NSArray<NSDictionary *> *dataArray = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray <VTDataShopCard *> *results = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in dataArray) {
        VTDataShopCard *dataShopCard = [[VTDataShopCard alloc] initWithDictionary:dic];
        [results addObject:dataShopCard];
    }
    
    VTDataSearchResults *dataSearchResults = [[VTDataSearchResults alloc] initWithShopCards:results];
    completion(dataSearchResults);
}

@end
