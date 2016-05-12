//
//  ZHMeViewController.m
//  bantang
//
//  Created by MS on 15-12-28.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHMeViewController.h"
#import "DataManager.h"
#import "ZHListManager.h"
#import "NYSegmentedControl.h"
#import "ZHProductViewController.h"
#import "ZHConnecViewController.h"
#import "ZHGoodsDetailViewController.h"
#import "MJRefresh.h"
#import "ZHUIFactory.h"
@interface ZHMeViewController ()<UIScrollViewDelegate>{
}
@property(nonatomic,strong)UIScrollView *mainScrollView;
@property(nonatomic,strong)NYSegmentedControl *segement;
@property(nonatomic,strong)NSArray *buttons;
@property(nonatomic,strong)ZHProductViewController  *productVC;
@property(nonatomic,strong)ZHConnecViewController *connecVC;
@property(nonatomic,strong)NSMutableArray *vcArray;

@property(nonatomic,copy)NSString  *productUrlStr;


@end

@implementation ZHMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
    
    //    创建segement
    [self createSegement];
    
}
/**
 *  创建segement
 */
-(void)createSegement{
    _buttons = @[@"我的收藏",@"我的关注"];
    
    self.segement = [[NYSegmentedControl alloc]initWithItems:_buttons];
    self.segement.borderWidth = 2.0f*0.618f;
    self.segement.borderColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    self.segement.segmentIndicatorInset = 0.618f;
    self.segement.drawsSegmentIndicatorGradientBackground = YES;
    self.segement.segmentIndicatorGradientTopColor = [UIColor redColor];
    self.segement.segmentIndicatorGradientBottomColor = [UIColor redColor];
    self.segement.segmentIndicatorAnimationDuration = 0.3f;
    self.segement.layer.cornerRadius = 15.0f;
    self.segement.titleTextColor = [UIColor whiteColor];
    self.segement.selectedTitleTextColor = [UIColor blackColor];
    self.segement.frame = CGRectMake(0, 0, 200, 30);
    self.segement.selectedSegmentIndex = 0;
    [self.segement addTarget:self action:@selector(segementPressed:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = self.segement;
    
    
    
    //    创建scrollView
    [self createMainScrollView];
}


/**
 *  创建一个scrollView放在最下面,用于滑动视图
 */
-(void)createMainScrollView{
    self.mainScrollView = [[UIScrollView alloc]init];
    self.mainScrollView.frame = [UIScreen mainScreen].bounds;
    self.mainScrollView.delegate = self;
    self.mainScrollView.pagingEnabled = YES;
    [self.view addSubview:self.mainScrollView];


    //    创建自定义子视图
    [self createSubTableViews];
}
/**
 *  创建自定义视图内的子视图
 */
-(void)createSubTableViews{
    CGFloat scrollW = self.mainScrollView.width;
    CGFloat scrollH = self.mainScrollView.height;
    
    self.productVC  = [ZHProductViewController new];
    
    
    self.connecVC = [ZHConnecViewController new];
    [_vcArray addObjectsFromArray:@[self.productVC,self.connecVC]];
    
    self.productVC.view.frame = CGRectMake(0, 0, scrollW,scrollH);
    
    self.connecVC.view.frame = CGRectMake(scrollW, 0, scrollW, scrollH);
    
    [self.mainScrollView addSubview:self.productVC.view];
    
    [self.mainScrollView addSubview:self.connecVC.view];

    self.mainScrollView.contentSize = CGSizeMake(self.buttons.count *scrollW, 0);
    
    //    让正在显示的视图刷新数据
    NSArray *Array = [[DataManager defaultManager]allModel];
    if (Array.count == 0) {
        [self.mainScrollView addSubview: [ZHUIFactory errorImageWithImage:[UIImage imageNamed:@"error_post_empty"] andText:@"然而并没有收藏"]];
        self.productVC.view.hidden = YES;
        return;
    }
    self.productVC.view.hidden = NO;
    UIView *view = [self.mainScrollView viewWithTag:1001];
    view.hidden = YES;
    NSMutableString *urlStr = [NSMutableString new];
    for (ZHListModel *listModel in Array) {
        [urlStr appendFormat:@"%@,",listModel.id];
    }
//    截取最后一个逗号
    [urlStr deleteCharactersInRange:NSMakeRange(urlStr.length - 1, 1)];
    self.productUrlStr = [product_list_url stringByAppendingString:urlStr];
//    拼接网址
    self.productVC.urlStr = self.productUrlStr;
//    加载数据
    [self.productVC loadData];
    
   __weak ZHMeViewController* weakSelf = self;
    [self.productVC setShowVC:^(NSString *id) {
        ZHGoodsDetailViewController *goods = [ZHGoodsDetailViewController new];
        goods.idStr = id;
        
        [weakSelf.navigationController pushViewController:goods animated:YES];
    }];
    
    
   
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *Array = [[DataManager defaultManager]allModel];
    if (Array.count == 0) {
        [self.mainScrollView addSubview: [ZHUIFactory errorImageWithImage:[UIImage imageNamed:@"error_post_empty"] andText:@"然而并没有收藏"]];
        self.productVC.view.hidden = YES;
        return;
    }
    self.productVC.view.hidden = NO;
    UIView *view = [self.mainScrollView viewWithTag:1001];
    [view removeFromSuperview];
    NSMutableString *urlStr = [NSMutableString new];
    for (ZHListModel *listModel in Array) {
        [urlStr appendFormat:@"%@,",listModel.id];
    }
    //    截取最后一个逗号
    [urlStr deleteCharactersInRange:NSMakeRange(urlStr.length - 1, 1)];
    self.productUrlStr = [product_list_url stringByAppendingString:urlStr];
    self.productVC.urlStr = self.productUrlStr;
    
    
    [self.productVC loadData];

    [self.connecVC loadData];
    
    
}




#pragma mark - segement的回调方法
-(void)segementPressed:(NYSegmentedControl *)segement{
    if (segement.selectedSegmentIndex == 0) {
        //    让正在显示的视图刷新数据
        NSArray *Array = [[DataManager defaultManager]allModel];
        if (Array.count == 0) {
            [self.mainScrollView addSubview: [ZHUIFactory errorImageWithImage:[UIImage imageNamed:@"error_post_empty"] andText:@"然而并没有收藏"]];
            self.productVC.view.hidden = YES;
            return;
        }
        self.productVC.view.hidden = NO;
        UIView *view = [self.mainScrollView viewWithTag:1001];
        NSLog(@"%@",view);
        [view removeFromSuperview];
        NSMutableString *urlStr = [NSMutableString new];
        for (ZHListModel *listModel in Array) {
            [urlStr appendFormat:@"%@,",listModel.id];
        }
        //    截取最后一个逗号
        [urlStr deleteCharactersInRange:NSMakeRange(urlStr.length - 1, 1)];
        self.productUrlStr = [product_list_url stringByAppendingString:urlStr];
        self.productVC.urlStr = self.productUrlStr;
        [self.productVC loadData];

    }else if (segement.selectedSegmentIndex ==1 ){
        
    }
    [UIView animateWithDuration:0.3 animations:^{
        [_mainScrollView setContentOffset:CGPointMake(WIDTH * segement.selectedSegmentIndex, 0)];
    }];
    
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index = self.mainScrollView.contentOffset.x/WIDTH;
    if (index == 0) {
        //    让正在显示的视图刷新数据
        NSArray *Array = [[DataManager defaultManager]allModel];
        if (Array.count == 0) {
            [self.mainScrollView addSubview: [ZHUIFactory errorImageWithImage:[UIImage imageNamed:@"error_post_empty"] andText:@"然而并没有收藏"]];
            self.productVC.view.hidden = YES;
            return;
        }
        self.productVC.view.hidden = NO;
        UIView *view = [self.mainScrollView viewWithTag:1001];
        view.hidden = YES;
        NSMutableString *urlStr = [NSMutableString new];
        for (ZHListModel *listModel in Array) {
            [urlStr appendFormat:@"%@,",listModel.id];
        }
        //    截取最后一个逗号
        [urlStr deleteCharactersInRange:NSMakeRange(urlStr.length - 1, 1)];
        self.productUrlStr = [product_list_url stringByAppendingString:urlStr];
        self.productVC.urlStr = self.productUrlStr;

        [self.productVC loadData];
    }else if (index == 1){

    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.segement.selectedSegmentIndex =  index;
    }];
    
    
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
