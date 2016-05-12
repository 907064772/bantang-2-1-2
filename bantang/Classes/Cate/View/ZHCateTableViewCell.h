//
//  ZHCateTableViewCell.h
//  bantang
//
//  Created by MS on 15-12-30.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHListModel.h"
#import "ZHDataModel.h"
#import "ZHButton.h"
@interface ZHCateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLabelContraint;



@property (weak, nonatomic) IBOutlet UIButton *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *userIdButton;
@property (weak, nonatomic) IBOutlet UILabel *datestrLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIImageView *picsImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likesBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomBtn;


@property (weak, nonatomic) IBOutlet ZHButton *linkBtn;
@property (weak, nonatomic) IBOutlet UIImageView *sellerImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UIImageView *platformIcon;
@property (weak, nonatomic) IBOutlet UILabel *platformLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet ZHButton *buyBtn;

/**
 * 购买的block回调
 */
@property(nonatomic,copy)void(^buyWebView)(NSString *urlStr);



@property(nonatomic,strong)ZHListModel  *listModel;

+(CGFloat)heightForRow:(ZHListModel *)listModel;





@end
