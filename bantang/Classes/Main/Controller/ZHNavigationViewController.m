//
//  ZHNavigationViewController.m
//  bantang
//
//  Created by MS on 15-12-28.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHNavigationViewController.h"
#import "UIBarButtonItem+Extension.h"
@interface ZHNavigationViewController ()

@end

@implementation ZHNavigationViewController
/**
*  当第一次使用这个类的时候调用,只调用一次
*/
+(void)initialize{
    
    [self setUpBarButtonItemTheme];
    
    
    
}
+(void)setUpBarButtonItemTheme{
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    NSMutableDictionary *textAtts = [NSMutableDictionary new];
    textAtts[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAtts[NSFontAttributeName] = [UIFont systemFontOfSize:FONTMAX];
    [appearance setTitleTextAttributes:textAtts forState:UIControlStateNormal];
    
    
    
    NSMutableDictionary *hightextAtts = [NSMutableDictionary dictionaryWithDictionary:textAtts];
    hightextAtts[NSForegroundColorAttributeName] = [UIColor redColor];
    
    [appearance setTitleTextAttributes:hightextAtts forState:UIControlStateHighlighted];
    NSMutableDictionary *disableTextAtts = [NSMutableDictionary dictionaryWithDictionary:textAtts];
    disableTextAtts[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disableTextAtts forState:UIControlStateDisabled];
    
    
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    
    
    
}






-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem  itemWithImageName:@"btn_product_detail_back" highImageName:@"tb_icon_navigation_back" target:self action:@selector(back)];
        
        
        

    }
    [super pushViewController:viewController animated:YES];
    
}





-(void)back{
    [self popViewControllerAnimated:YES];
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
