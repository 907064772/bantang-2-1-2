//
//  ZHHomeViewController.h
//  bantang
//
//  Created by MS on 15-12-28.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHBaseViewController.h"
@class ZHBtnScrollView,ZHSubViewController,SDCycleScrollView;
@interface ZHHomeViewController : ZHBaseViewController



@property(nonatomic,strong)SDCycleScrollView *topScrollView;

@property(nonatomic,strong)ZHBtnScrollView *btnScrollView;



@property(nonatomic,strong)UIScrollView *scrollView;






@end
