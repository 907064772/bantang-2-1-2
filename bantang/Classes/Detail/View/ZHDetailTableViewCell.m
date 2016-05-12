//
//  ZHDetailTableViewCell.m
//  bantang
//
//  Created by MS on 16-1-4.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHDetailTableViewCell.h"
#import "ZHUIFactory.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"

@implementation ZHDetailTableViewCell


- (void)awakeFromNib {
    // Initialization code
}




/**
 *  设置cell元素
 *
 *  @param dataModel <#dataModel description#>
 */
-(void)setProductModel:(ZHDataModel *)productModel{
//    self.productModel = productModel;
    self.titleLabel.text = productModel.title;
    self.priceLabel.text = [NSString stringWithFormat:@"参考价格:￥%@",productModel.price];
    self.likesNumberLabel.text = [NSString stringWithFormat:@"%@ 喜欢",productModel.likes];
    [self.favorite setTitle:productModel.likes forState:UIControlStateNormal];
//    如果网址为就设置按钮否则就是暂无链接
    if (productModel.url.length) {
        [self.buyBtn setImage:[UIImage imageNamed:@"btn_product_buy"] forState:UIControlStateNormal];
        [self.buyBtn setImage:[UIImage imageNamed:@"btn_product_buy_highlighted"] forState:UIControlStateSelected];
        self.buyBtn.urlStr = productModel.url;
    }else{
        [self.buyBtn setTitle:@"暂无链接" forState:UIControlStateNormal];
    }
    
    
    
    
    
    
//    动态计算desc的文字高度
    CGSize size = [productModel.desc boundingRectWithSize:CGSizeMake(WIDTH - 18 , CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.descLabel.font} context:nil].size;
//    给label的约束高赋值
    self.descLabelConstaint.constant = size.height+10;
    
    self.descLabel.text = productModel.desc;
//    给图片赋值
    for (int i = 0; i<productModel.pic.count; i++) {
        NSDictionary *pic = productModel.pic[i];
        if (i == 0) {
            [_picOne sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",_dataModel.product_pic_host,pic[@"p"]]] placeholderImage:[UIImage imageNamed:@"default_user_loading_icon"]];
        }else if (i == 1){
            [_picTwo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",_dataModel.product_pic_host,pic[@"p"]]] placeholderImage:[UIImage imageNamed:@"default_user_loading_icon"]];
        }
    }
//    动态计算.图片的高度
    if (productModel.pic.count<2) {
        _picTwo.hidden = YES;
        
        _picTwoConstaint.constant = 0;
    }else{
        _picTwo.hidden = NO;
        _picTwoConstaint.constant = _picOneConstraint.constant;
    }
//    设置用户头像
    for (int i = 1; i<(productModel.likes_list.count>8?8:productModel.likes_list.count); i++) {
        Likes *like =  productModel.likes_list[i];
        UIButton *btn = (id)[self.btnView viewWithTag:100+i];
        btn.imageView.image = nil;
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",_dataModel.user_avatr_host,like.a]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    
}
/**
 *  btn的回调方法
 */
-(void)btnClick:(ZHButton *)btn{

}
- (IBAction)buyBtnClick:(ZHButton *)sender {
    if (self.buyWebView) {
        self.buyWebView(sender.urlStr);
    }
    
    
}

/**
 *  返回cell的高度
 *
 *  @return <#return value description#>
 */
+(CGFloat)heightForRow:(ZHDataModel *)productModel{
    
    //    动态计算desc的文字高度
    CGSize size = [productModel.desc boundingRectWithSize:CGSizeMake(WIDTH - 18 , CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONTMIN]} context:nil].size;
//    两张图片的高度加上一个label和其他控件的高度
    return  304*productModel.pic.count + size.height + 125 + 62;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
