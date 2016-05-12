//
//  PageTwoCell.m
//  sugar
//
//  Created by MS on 16-1-6.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "PageTwoCell.h"
#import "UIImageView+WebCache.h"
@implementation PageTwoCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setListModel:(ZHListModel *)listModel{
    
    _listModel = listModel;

    [self.bigImage sd_setImageWithURL:[NSURL URLWithString:listModel.pic2] placeholderImage:[UIImage imageNamed:@"default_user_loading_icon"]];
    
    self.nameLabel.text = listModel.name;
    self.likeLabel.text = [NSString stringWithFormat:@"%@人喜欢",listModel.dynamic.attentions];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
