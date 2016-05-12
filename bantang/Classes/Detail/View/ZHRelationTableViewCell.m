//
//  ZHRelationTableViewCell.m
//  bantang
//
//  Created by MS on 16-1-8.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHRelationTableViewCell.h"
#import "ZHRelationCollectionViewController.h"

@interface ZHRelationTableViewCell (){
    ZHRelationCollectionViewController *_relation;
}

@end


@implementation ZHRelationTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UICollectionViewLayout *layout = [[UICollectionViewLayout alloc]init];
        
        self.contentView.bounds = CGRectMake(0, 0, WIDTH, 44);
        _relation = [[ZHRelationCollectionViewController alloc]initWithCollectionViewLayout:layout];

        __weak ZHRelationTableViewCell *weekSelf = self;
        

        //collectionView返回出来的数据模型,
        [_relation setBlock:^(ZHListModel *list) {
            if (weekSelf.showVC) {
                weekSelf.showVC(list);
            }
            
        }];
        [self.contentView addSubview:_relation.view];
        
    }
    return  self;
    
}

- (void)awakeFromNib {
    
    // Initialization code
    
    
    
}

-(void)setProduct:(ZHListModel *)product{

    _relation.product = product;
    

    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
