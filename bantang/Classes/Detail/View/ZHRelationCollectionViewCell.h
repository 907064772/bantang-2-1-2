//
//  ZHRelationCollectionViewCell.h
//  bantang
//
//  Created by MS on 16-1-8.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHListModel.h"
@interface ZHRelationCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topicIV;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

@property(nonatomic,strong)ZHListModel *listModel;

@end
