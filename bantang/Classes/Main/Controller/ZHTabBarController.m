//
//  ZHTabBarController.m
//  bantang
//
//  Created by MS on 15-12-28.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHTabBarController.h"
#import "ZHNavigationViewController.h"
#import "ZHHomeViewController.h"
#import "ZHCommunityViewController.h"
#import "ZHMessageViewController.h"
#import "ZHMeViewController.h"
#import "ZHTabbar.h"


@interface ZHTabBarController ()

@end

@implementation ZHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    替换掉系统的tabbar
    [self customTabBar];
    
    
    ZHHomeViewController *home = [[ZHHomeViewController alloc]init];
    [self addAllChildVc:home andTitle:@"首页" andImage:[UIImage imageNamed:@"tab_首页"] andSelectedImage:[UIImage imageNamed:@"tab_首页_pressed"]];
    
    ZHCommunityViewController *cate = [ZHCommunityViewController new];
    [self addAllChildVc:cate andTitle:@"社区" andImage:[UIImage imageNamed:@"tab_社区"] andSelectedImage:[UIImage imageNamed:@"tab_社区_pressed"]];
    
    ZHMessageViewController *message = [ZHMessageViewController new];
    [self addAllChildVc:message andTitle:@"分类" andImage:[UIImage imageNamed:@"tab_分类"] andSelectedImage:[UIImage imageNamed:@"tab_分类_pressed"]];
    
    ZHMeViewController *me = [ZHMeViewController new];
    [self addAllChildVc:me andTitle:@"我" andImage:[UIImage imageNamed:@"tab_我的"] andSelectedImage:[UIImage imageNamed:@"tab_我的_pressed"]];
    
    self.selectedIndex = 0;
    
}
-(void)customTabBar{
//    ZHTabbar *custom = [ZHTabbar new];
//    [self setValue:custom forKeyPath:@"tabBar"];
}



-(void)addAllChildVc:(UIViewController *)child andTitle:(NSString *)title andImage:(UIImage *)image andSelectedImage:(UIImage *)selectedImage{
    
    child.title = title;
    child.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    child.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ZHNavigationViewController *nav = [[ZHNavigationViewController alloc]initWithRootViewController:child];
    
    
    [self addChildViewController:nav];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
