//
//  ZHDetailViewController.h
//  bantang
//
//  Created by MS on 16-1-4.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHDataModel;
@interface ZHDetailViewController : UIViewController
@property(nonatomic,copy)NSString  *idStr;
@property (strong, nonatomic) UILabel *descLabel;
/**
 *  创建头视图
 */
-(void)createHeaderView;
//设置为tableView的头视图,计算header的大小
-(void)headerViewFrame:(ZHDataModel *)dataModel;
/**
 *  设置头视图元素
 */
-(void)setHeaderViewItem:(ZHDataModel *)dataModel;
@end
