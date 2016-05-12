//
//  ZHRelationCollectionViewCell.m
//  bantang
//
//  Created by MS on 16-1-8.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHRelationCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ZHRelationCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    

    
    
}

/**
  *  设置xib里面的数据
  *
  *  @param listModel
  */
-(void)setListModel:(ZHListModel *)listModel{
    [self.topicIV   sd_setImageWithURL:[NSURL URLWithString:listModel.pic] placeholderImage:[UIImage imageNamed:@"default_user_loading_icon"]];
    self.titleLabel.text = listModel.title;
    self.priceLabel.text = listModel.price;
    [self.likeBtn setTitle:listModel.likes  forState:UIControlStateNormal];
}




@end
