//
//  ZHTopicTableViewCell.m
//  bantang
//
//  Created by MS on 16-1-9.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHTopicTableViewCell.h"






@implementation ZHTopicTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}


-(void)setTopic:(NSArray *)topic{
    _topic = topic;
    NSMutableArray *images = [NSMutableArray new];
    NSMutableArray *titles = [NSMutableArray new];
    for (ZHListModel *pic in topic) {
        [images addObject:pic.pic];
        [titles addObject:pic.title];
        
    }

    
    SDCycleScrollView * topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 20, self.contentView.width, self.contentView.height - 20) imageURLStringsGroup:images];
    topScrollView.delegate = self;
    [topScrollView setBackgroundColor:[UIColor clearColor]];
    topScrollView.dotColor = [UIColor whiteColor];
    topScrollView.placeholderImage = [UIImage imageNamed:@"default_user_loading_icon"];
    topScrollView.autoScrollTimeInterval = 2.0;
    topScrollView.titlesGroup = titles;
    
    [self.contentView addSubview:topScrollView];
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    ZHListModel *list = _topic[index];
    if (self.showDetailVC) {
        self.showDetailVC(list.id);
    }
    
    
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
