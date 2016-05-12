//
//  ZHTopPicCell.h
//  bantang
//
//  Created by MS on 15-12-29.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHTopicModel.h"
@interface ZHTopPicCell : UITableViewCell



@property(nonatomic,strong)ZHTopicModel  *topic;

@property (weak, nonatomic) IBOutlet UIImageView *ImgView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *enjoyBtn;
@property (weak, nonatomic) IBOutlet UIImageView *islikeIV;
/**
 *  计算每行cell的高度
 *
 *  @return <#return value description#>
 */
+(CGFloat)heightForRow;

@end
