//
//  ZHCateViewController.h
//  bantang
//
//  Created by MS on 15-12-28.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHBaseViewController.h"
#import "ZHWebViewController.h"
@interface ZHCateViewController : ZHBaseViewController

@property(nonatomic,copy)void(^showWebView)(NSString *urlStr);


/**
 *  刷新数据
 */
-(void)refreshData;

@end
