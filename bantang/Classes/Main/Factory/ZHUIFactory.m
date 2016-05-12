//
//  ZHUIFactory.m
//  HandKitchen
//
//  Created by MS on 15-12-21.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHUIFactory.h"

@implementation ZHUIFactory

/**
 *  提供一个主背景色
 */
+(UIColor *)mainBackgroundColor{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeview_bg"]];
}
/**
 *  导航栏左侧的专用按钮,没有事件
 */
+(UIBarButtonItem *)leftBarButtonItemWithString:(NSString *)string{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 44)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = string;
    
    return [[UIBarButtonItem alloc]initWithCustomView:label];
}
/**
 *  导航返回按钮
 *
 *  @return <#return value description#>
 */
+(UIBarButtonItem *)backBarbuttonItemWithTarget:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back_hl"] forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
/**
 *  快速创建一个button
 *
 *  @param UIButtonType <#UIButtonType description#>
 *  @param frame        <#frame description#>
 *  @param target       <#target description#>
 *  @param action       <#action description#>
 *
 *  @return <#return value description#>
 */

+(UIButton *)BunttonWithImageView:(UIButtonType)UIButtonType andFrame:(CGRect)frame andTarget:(id)target andAction:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonType];
    button.frame = frame;
    [button addTarget:target action:action   forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:FONTMIN];
    return button;
}

+(UIView *)errorImageWithImage:(UIImage *)image andText:(NSString *)text{
    
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.tag = 1001;
    
    UIImageView *iv = [[UIImageView alloc]initWithImage:image];
    iv.size = image.size;
    iv.center = CGPointMake(WIDTH/2, HEIGHT/2);
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(iv.frame), WIDTH, 20)];
    label.text = text;
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:FONTMIN];
    [view addSubview:iv];
    [view addSubview:label];
    
    
    return view;
}


@end
