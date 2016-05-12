//
//  ZHCommunityViewController.m
//  bantang
//
//  Created by MS on 15-12-29.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHCommunityViewController.h"
#import "NYSegmentedControl.h"
#import "ZHCateViewController.h"
#import "ZHAttentionViewController.h"
#import "ZHPlazaViewController.h"

@interface ZHCommunityViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong )UIScrollView *mainScrollView;
@property(nonatomic,strong)NSArray *buttons;
@property(nonatomic,strong)NYSegmentedControl *segement;
@property(nonatomic,strong)ZHCateViewController  *cateVC;
@property(nonatomic,strong)ZHAttentionViewController *attentionVC;
@property(nonatomic,strong)NSMutableArray *vcArray;

@end

@implementation ZHCommunityViewController

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
    _buttons = @[@"精选",@"广场"];

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
    
    self.cateVC = [ZHCateViewController new];
    
    __weak ZHCommunityViewController* weakSelf = self;
    [self.cateVC setShowWebView:^(NSString *urlStr) {
        ZHWebViewController *webView = [[ZHWebViewController alloc]init];
        webView.urlStr = urlStr;
        [weakSelf.navigationController pushViewController:webView animated:YES];
        
    }];
    
    
    self.attentionVC = [ZHAttentionViewController new];
    [_vcArray addObjectsFromArray:@[self.cateVC,self.attentionVC]];
    
    self.cateVC.view.frame = CGRectMake(0, 0, scrollW,scrollH);
    
    self.attentionVC.view.frame = CGRectMake(scrollW, 0, scrollW, scrollH);
    [self.attentionVC setShowVC:^(NSString *id, NSString *name) {
        ZHPlazaViewController *plaza = [ZHPlazaViewController new];
        plaza.idStr = id;
        plaza.title = name;

        [weakSelf.navigationController pushViewController:plaza animated:YES];
        
    }];

    [self.mainScrollView addSubview:self.cateVC.view];
    [self.mainScrollView addSubview:self.attentionVC.view];
    
    
    self.mainScrollView.contentSize = CGSizeMake(self.buttons.count *scrollW, 0);
    
//    让正在显示的视图刷新数据
    self.cateVC.urlStr = carefully_url;
    
    [self.cateVC refreshData];
    
    
    
    
    
    


}
    



#pragma mark - segement的回调方法
-(void)segementPressed:(NYSegmentedControl *)segement{
    if (segement.selectedSegmentIndex == 0) {
        self.cateVC.urlStr = carefully_url;
        [self.cateVC refreshData];
    }else if (segement.selectedSegmentIndex ==1 ){
        self.attentionVC.urlStr = plaza_url;
        [self.attentionVC loadData];
        
    }
    [UIView animateWithDuration:0.3 animations:^{
       [_mainScrollView setContentOffset:CGPointMake(WIDTH * segement.selectedSegmentIndex, 0)];
    }];
    
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index = self.mainScrollView.contentOffset.x/WIDTH;
    if (index == 0) {
        self.cateVC.urlStr = carefully_url;
        [self.cateVC refreshData];
    }else if (index == 1){
        self.attentionVC.urlStr = plaza_url;
        [self.attentionVC loadData];
        
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
