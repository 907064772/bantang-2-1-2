//
//  ZHCateTableViewCell.m
//  bantang
//
//  Created by MS on 15-12-30.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHCateTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "DataManager.h"
#import "KVNProgress.h"
#import "ZHListManager.h"
#import "UMSocial.h"

@implementation ZHCateTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.iconImageView.layer.cornerRadius = 15;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setListModel:(ZHListModel *)listModel{
    _listModel = listModel;
    Pics *pic = [listModel.pics firstObject];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:listModel.author.avatar] forState:UIControlStateNormal];
    [self.userIdButton setTitle:listModel.author.nickname forState:UIControlStateNormal];
    self.datestrLabel.text = listModel.datestr;
    [self.picsImageView sd_setImageWithURL:[NSURL URLWithString:pic.url]];
    
    self.contentLabel.text = listModel.content;
    CGSize size = [listModel.content boundingRectWithSize:CGSizeMake(self.contentLabel.width - 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.contentLabel.font} context:nil].size;
    self.textLabelContraint.constant = size.height+20;
    
    NSMutableString *string = [NSMutableString new];
    for (NSDictionary *dic in listModel.tags) {
        [string appendFormat:@"     %@",dic[@"name"]];
        self.tagNameLabel.text = string;
    }
    self.tagNameLabel.y = self.contentLabel.y + size.height + 10;

    [self.likesBtn setTitle:listModel.dynamic.likes forState:UIControlStateNormal];
    
    //    先从数据库中读取所有的单品,看是否有相同的,如果有就让按钮的选中状态为yes,否则正常显示
    NSArray * array = [[DataManager defaultManager] allModel];
    for (ZHListModel *dm in array) {
        if ([dm.id isEqualToString: _listModel.id]) {
            NSLog(@"%@%@",dm.id, _listModel.id);
            _likesBtn.selected = YES;
        }else{
            _likesBtn.selected = NO;
        }
    }
    
    self.bottomBtn.y = self.tagNameLabel.y + self.bottomBtn.height + 10;
    
    

    
    if (listModel.product.count<1) {
        [self.linkBtn setTitle:@"暂无链接" forState:UIControlStateNormal];
        self.linkBtn.backgroundColor = [UIColor whiteColor];
        [self.buyBtn setTitle:@"暂无链接" forState:UIControlStateNormal];
        [self.buyBtn setBackgroundImage:nil forState:UIControlStateNormal];
        self.buyBtn.enabled = NO;
        self.linkBtn.enabled = NO;
    }else{
        
        self.buyBtn.enabled = YES;
        self.linkBtn.enabled = YES;
        
        [self.linkBtn setTitle:@"" forState:UIControlStateNormal];
        self.linkBtn.backgroundColor = [UIColor clearColor];
        ZHListModel *product = listModel.product[0];
        self.linkBtn.urlStr = product.url;
        
        
        [self.sellerImageView sd_setImageWithURL:[NSURL URLWithString:product.pic]];
        self.goodsName.text = product.title;
        if ([product.platform integerValue] == 1) {
            self.platformIcon.image = [UIImage imageNamed:@"community_taobao_icon"];
            self.platformLabel.text = @"来自淘宝";
        }else{
            self.platformIcon.image = [UIImage imageNamed:@"community_tianmao"];
            self.platformLabel.text = @"来自天猫";
        }
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",product.price];
        
        
        [self.buyBtn setTitle:@"" forState:UIControlStateNormal];
        self.buyBtn.urlStr = product.url;
        [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"tools_taobao_btn"] forState:UIControlStateNormal];
        [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"tools_taobao_btn_pressed"] forState:UIControlStateHighlighted];
    }
    

    
}

/**
 *  喜欢按钮
 *
 *  @param sender btn
 */
- (IBAction)islikeBtnClick:(UIButton *)sender {
    _likesBtn.selected = !_likesBtn.selected;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadData" object:nil];
    _listModel.image = UIImagePNGRepresentation(_picsImageView.image);
    if (_likesBtn.selected) {
        _likesBtn.titleLabel.text = [NSString stringWithFormat:@"%d",[_likesBtn.titleLabel.text intValue] + 1];
        
        [[ZHListManager defaultManager]insertDataWithModel:_listModel];
        [KVNProgress showSuccessWithStatus:@"互动成功"];
        
    }else{
        _likesBtn.titleLabel.text = [NSString stringWithFormat:@"%d",[_likesBtn.titleLabel.text intValue] - 1];
        [[ZHListManager defaultManager]deleteUserWithId:_listModel.id];
        [KVNProgress showSuccessWithStatus:@"取消互动"];
    }
    
    
}
/**
 *  购买按钮
 *
 *  @param sender btn
 */
- (IBAction)buyBtnClick:(ZHButton *)sender {
    
    if (self.buyWebView) {
        self.buyWebView(sender.urlStr);
    }
    
    
}


- (IBAction)sharebtn:(UIButton *)sender {
    

    Pics *pic = [_listModel.pics firstObject];
    UIImageView *iv = [UIImageView new];
    [iv sd_setImageWithURL:[NSURL URLWithString:pic.pic]];
    
    
    [UMSocialSnsService presentSnsIconSheetView:nil appKey:@"56935b7767e58eb6b50004e0" shareText:[NSString stringWithFormat:@"%@\n%@",_listModel.url,_listModel.title] shareImage:iv.image shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToDouban,UMShareToEmail,UMShareToSms,UMShareToFacebook,UMShareToTwitter,nil] delegate:nil];

}

/**
 *  计算cell的高度
 *
 *  @return 返回出去
 */
+(CGFloat)heightForRow:(ZHListModel *)listModel{
    CGSize size = [listModel.content boundingRectWithSize:CGSizeMake(335-2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONTMIN]} context:nil].size;
    return 599 + size.height;
    
}

- (IBAction)attentionBtnClick:(UIButton *)sender {
    _attentionBtn.selected = !_attentionBtn.selected;
    ZHListManager *manager = [ZHListManager defaultManager];
    [manager insertDataWithModel:_listModel];
    
}

- (IBAction)idButton:(UIButton *)sender {
    NSLog(@"要调到人得控制器");
    
}
@end
