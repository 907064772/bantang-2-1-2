//
//  ZHSearchListCollectionViewCell.m
//  bantang
//
//  Created by MS on 16-1-12.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHSearchListCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ZHSearchListCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setBm:(ZHBannerModel *)bm{
    _bm = bm;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:bm.icon]];
    self.titleLabel.text = bm.name;
    self.typeLabel.text = bm.en_name;
    
    
    
}

@end
