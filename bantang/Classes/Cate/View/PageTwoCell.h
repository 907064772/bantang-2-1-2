//
//  PageTwoCell.h
//  sugar
//
//  Created by MS on 16-1-6.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHListModel.h"
@interface PageTwoCell : UITableViewCell

@property(nonatomic,strong)ZHListModel *listModel;

@property (weak, nonatomic) IBOutlet UIImageView *bigImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@end
