//
//  ZHUIFactory.h
//  HandKitchen
//
//  Created by MS on 15-12-21.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZHUIFactory : NSObject
/**
 *  提供一个主背景色
 */
+(UIColor *)mainBackgroundColor;
/**
 *  导航栏左侧的专用按钮,没有事件
 */
+(UIBarButtonItem *)leftBarButtonItemWithString:(NSString *)string;
/**
 *  导航返回按钮
 */
+(UIBarButtonItem *)backBarbuttonItemWithTarget:(id)target action:(SEL)action;

/**
 *  返回一个普通按钮
 *
 *  @param UIButtonType <#UIButtonType description#>
 *  @param frame        <#frame description#>
 *  @param target       <#target description#>
 *  @param action       <#action description#>
 *
 *  @return <#return value description#>
 */
+(UIButton *)BunttonWithImageView:(UIButtonType)UIButtonType andFrame:(CGRect)frame andTarget:(id)target andAction:(SEL)action;
/**
 *  错误图片和label
 */
+(UIView *)errorImageWithImage:(UIImage *)image andText:(NSString *)text;




@end
