//
//  ZHDetailTableViewCell.h
//  bantang
//
//  Created by MS on 16-1-4.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHDataModel.h"
#import "ZHListModel.h"
#import "ZHButton.h"

@interface ZHDetailTableViewCell : UITableViewCell


@property(nonatomic,strong)ZHDataModel *productModel;
@property(nonatomic,strong)ZHDataModel *dataModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descLabelConstaint;


@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picTwoConstaint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picOneConstraint;


@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UIImageView *goodIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picOne;
@property (weak, nonatomic) IBOutlet UIImageView *picTwo;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (weak, nonatomic) IBOutlet UIButton *favorite;
@property (weak, nonatomic) IBOutlet ZHButton  *buyBtn;

@property(nonatomic,copy)void(^buyWebView)(NSString *urlStr);



+(CGFloat)heightForRow:(ZHDataModel *)productModel;

@end
