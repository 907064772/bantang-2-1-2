//
//  ZHHeaderViewTableViewCell.m
//  bantang
//
//  Created by MS on 16-1-9.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHHeaderViewTableViewCell.h"
#import "ZHDetailHeaderView.h"
#import "ZHListModel.h"

@interface ZHHeaderViewTableViewCell ()
@property(nonatomic,strong)ZHDetailHeaderView *view;


@end

@implementation ZHHeaderViewTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _view = [[ZHDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH + 40)];
        
        
        [self.contentView addSubview:_view];

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    
}

-(void)setDataModel:(ZHDataModel *)dataModel{
    ZHDataModel *product = dataModel.product;
    NSMutableArray *tempArr = [NSMutableArray new];
    for (NSDictionary  *pic in product.pic) {
        [tempArr addObject:pic[@"pic"]];
    }
    _view.price.text = product.price;
    _view.desc = product.desc;
    _view.images = tempArr;
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
