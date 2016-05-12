//
//  ZHTopicTableViewCell.h
//  bantang
//
//  Created by MS on 16-1-9.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHListModel.h"
#import "SDCycleScrollView.h"
@interface ZHTopicTableViewCell : UITableViewCell <SDCycleScrollViewDelegate>


@property(nonatomic,strong)NSArray  *topic;


@property(nonatomic,copy)void(^showDetailVC)(id str);

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
