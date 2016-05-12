//
//  ZHProductViewController.h
//  bantang
//
//  Created by MS on 16-1-19.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHProductViewController : UIViewController

@property(nonatomic,copy)void(^showVC)(NSString *id);

@property(nonatomic,copy)NSString  *urlStr;


//网络刷新成功后的回调
@property(nonatomic,copy)void(^block)();
/**
 *  加载数据
 */
-(void)loadData;

@end
