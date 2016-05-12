//
//  ZHRecommendTableViewController.h
//  bantang
//
//  Created by MS on 16-1-6.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHDetailViewController.h"
@interface ZHRecommendTableViewController : ZHDetailViewController


@property(nonatomic,strong)NSMutableArray *product;
@property(nonatomic,strong)NSMutableArray *dataModel;








/**
 *  加载数据
 */
-(void)loadData;


@end
