//
//  ZHSubViewController.h
//  bantang
//
//  Created by MS on 15-12-28.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHSubViewController : UITableViewController


@property(nonatomic,copy)NSString  *urlStr;

@property(nonatomic,copy)void(^showSubViews)(UIViewController *vc);



/**
 * 请求数据
 */
-(void)loadData;

@end
