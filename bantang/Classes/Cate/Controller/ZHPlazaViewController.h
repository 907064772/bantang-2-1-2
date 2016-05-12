//
//  ZHPlazaViewController.h
//  bantang
//
//  Created by MS on 16-1-18.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHPlazaViewController : UIViewController
@property(nonatomic,copy)NSString  *idStr;
/**
 *  展示淘宝的webView
 */
@property(nonatomic,copy)void(^showWebView)(NSString *urlStr);
/**
 *  加载数据
 */
-(void)loadData;

@end
