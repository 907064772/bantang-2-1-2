//
//  ZHHeaderView.h
//  bantang
//
//  Created by MS on 16-1-7.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHDetailHeaderView : UIView


@property(nonatomic,strong)NSArray *images;

@property(nonatomic,strong)UILabel *price;
@property(nonatomic,copy)NSString  *desc;

@property(nonatomic,assign)CGFloat height;


@end
