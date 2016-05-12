//
//  ZHTabbar.m
//  bantang
//
//  Created by MS on 15-12-28.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHTabbar.h"
#import "UIView+Extension.h"
@interface ZHTabbar ()

@property(nonatomic,strong)UIButton *plusBtn;


@end


@implementation ZHTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加加号按钮
        [self addPlusButton];
    }
    return self;
}
/**
 *  添加加号按钮
 */
-(void)addPlusButton{
    UIButton *btn = [UIButton new];
    [btn setImage:[UIImage imageNamed:@"tab_publish_add"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"tab_publish_add_pressed"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(plusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.plusBtn = btn;
    
    
    [self addSubview:btn];
    
}

/**
 *  设置加号按钮事件
 */
-(void)plusBtnClick:(UIButton *)btn{
    NSLog(@"plusBtnClick");
}


/**
 *  设置plusbtn的frame
 */
-(void)setUpPlusBtnFrame{

    self.plusBtn.size = CGSizeMake(self.width/5, self.height);
//
    self.plusBtn.centerX = self.width*0.5;
    self.plusBtn.centerY = self.height*0.5;

    
}
-(void)setUpAllTabBarBtnFrame{
    
    int index = 0;
    for (UIView *tabBarButton in self.subviews) {
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            如果不是tabbarbtn就跳出这个循环
            continue;
        }
        [self setUpTabBarBtnFrame:tabBarButton andIndex:index];
        index++;
    }
    
}

/**
 *  设置按钮的frame
 */
-(void)setUpTabBarBtnFrame:(UIView *)tabBarButton andIndex:(int )index{
//    获取按钮的宽和高
    CGFloat buttonW = self.width/5;
    CGFloat buttonH = self.height;
    
    tabBarButton.width = buttonW;
    tabBarButton.height = buttonH;
    tabBarButton.y = 0;
    if (index >= 2) {
        tabBarButton.x = buttonW *(index+1);
    }else{
        tabBarButton.x = buttonW *index;
    }
    
}

/**
 *  布局子视图
 */
-(void)layoutSubviews{
    [super layoutSubviews];
//    设置所有tabbarbtn的frame
    [self setUpAllTabBarBtnFrame];
//    设置加号按钮的frame
    [self setUpPlusBtnFrame];
}













/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
