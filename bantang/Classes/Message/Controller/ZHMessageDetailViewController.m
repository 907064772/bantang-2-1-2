//
//  ZHMessageDetailViewController.m
//  bantang
//
//  Created by MS on 16-1-18.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHMessageDetailViewController.h"
#import "ZHUIFactory.h"
@interface ZHMessageDetailViewController ()

@end

@implementation ZHMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview: [ZHUIFactory errorImageWithImage:[UIImage imageNamed:@"netError_bg_icon"] andText:@"木有信息"]];
    
    
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
