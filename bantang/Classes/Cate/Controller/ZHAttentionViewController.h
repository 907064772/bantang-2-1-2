//
//  ZHAttentionViewController.h
//  bantang
//
//  Created by MS on 15-12-29.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHBaseViewController.h"

@interface ZHAttentionViewController : ZHBaseViewController


@property(nonatomic,copy)void(^showVC)(NSString *id,NSString *name);

/**
 *  加载数据
 */
-(void)loadData;
@end
