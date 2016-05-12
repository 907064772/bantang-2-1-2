//
//  ZHMessageTableViewCell.h
//  bantang
//
//  Created by MS on 15-12-31.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHElementModel.h"
@interface ZHMessageTableViewCell : UITableViewCell


@property(nonatomic,strong)ZHElementModel  *elementModel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end
