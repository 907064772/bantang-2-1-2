//
//  ZHMessageTableViewCell.m
//  bantang
//
//  Created by MS on 15-12-31.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHMessageTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ZHMessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

-(void)setElementModel:(ZHElementModel *)elementModel{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:elementModel.pic]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
