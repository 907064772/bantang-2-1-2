//
//  ZHSearchListViewController.h
//  bantang
//
//  Created by MS on 16-1-12.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHSearchListViewController : UIViewController

@property(nonatomic,copy)NSString  *idStr;

@property(nonatomic,copy)void(^showVC)(id str,id name);

/**
 *  加载数据
 */
-(void)loadData;

@end
