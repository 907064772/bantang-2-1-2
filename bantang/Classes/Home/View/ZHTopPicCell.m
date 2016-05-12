//
//  ZHTopPicCell.m
//  bantang
//
//  Created by MS on 15-12-29.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHTopPicCell.h"
#import "UIImageView+WebCache.h"
@implementation ZHTopPicCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setTopic:(ZHTopicModel *)topic{
    [self.ImgView sd_setImageWithURL:[NSURL URLWithString:topic.pic] placeholderImage:[UIImage imageNamed:@"default_user_loading_icon"]];
    self.descLabel.text = topic.title;
    
    [self.enjoyBtn setTitle:topic.likes forState:UIControlStateNormal];
    self.islikeIV.image = [UIImage imageNamed:@"home_topic_new"];
    
#warning    new的图标,应该用系统更新时间的,这里只是假数据
    self.islikeIV.hidden = topic.islike;

    
}

/**
 *  计算每个cell的高度,让图片一直保持75:38
 *
 *  @return <#return value description#>
 */
+(CGFloat)heightForRow{
    return 251 - 190 + (WIDTH / 75 * 38) + 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
