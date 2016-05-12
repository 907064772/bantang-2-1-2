//
//  ZHSearchListCollectionViewCell.h
//  bantang
//
//  Created by MS on 16-1-12.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHBannerModel.h"
@interface ZHSearchListCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)ZHBannerModel *bm;

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end
