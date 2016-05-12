//
//  ZHSMainViewController.m
//  bantang
//
//  Created by MS on 16-1-12.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHSMainViewController.h"
#import "NYSegmentedControl.h"
#import "SearchViewController.h"
#import "ZHSearchListViewController.h"
#import "SearchDeatialController.h"
#import "ZHSubViewController.h"
#import "ZHSearchResultViewController.h"
#import "UIBarButtonItem+Extension.h"

@interface ZHSMainViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)NSArray *buttons;

@property(nonatomic,strong)NYSegmentedControl *segement;

@property(nonatomic,strong)SearchViewController *search;

@property(nonatomic,strong)ZHSearchListViewController *searchList;

@property(nonatomic,strong)NSArray *_vcArray;

@property(nonatomic,strong)UIScrollView *mainScrollView;

@property(nonatomic,strong)UISearchController *searchVC;

@property(nonatomic,strong)UIView *searchingView;

@property(nonatomic,strong)UIView *hotView;

@property(nonatomic,strong)NSMutableArray *hotTags;

@property(nonatomic,strong)NSArray *lists;

@property(nonatomic,strong)NYSegmentedControl *searchSegement;

@end

@implementation ZHSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _hotTags = [NSMutableArray new];
    // Do any additional setup after loading the view.
    
//    创建segement
    [self createSegement];
//    创建搜索框
//    [self createSearchBar];

}

/**
 * 设置搜索框
 */
-(void)createSearchBar{
    ZHSearchResultViewController *result =  [[ZHSearchResultViewController alloc]init];
    self.searchVC = [[UISearchController alloc]initWithSearchResultsController:result];
    
    self.searchVC.searchResultsController.view.frame = CGRectMake(0, 64, WIDTH, HEIGHT);
    self.searchVC.searchResultsUpdater = result;
    self.searchVC.dimsBackgroundDuringPresentation = NO;
    self.searchVC.hidesNavigationBarDuringPresentation = NO;
    self.searchVC.searchBar.width = WIDTH - 50;
    self.searchVC.searchBar.height = 44;
    self.searchVC.searchBar.placeholder = @"搜索 单品/清单/帖子/用户";
    
    self.navigationItem.titleView = self.searchVC.searchBar;

    
    
}





/**
 *  加载热门搜索数据
 */
-(void)loadHotSearchData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:hottags_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSString *str in responseObject[@"data"]) {
            [_hotTags addObject:str];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"热搜解析错误:%@",[error description]);
    }];
    
}






/**
 *  创建一个segement
 */
-(void)createSegement{
    _buttons = @[@"单品",@"清单"];
    

    self.segement.selectedSegmentIndex = 0;
    self.segement = [[NYSegmentedControl alloc]initWithItems:_buttons];
    self.segement.borderColor = [UIColor colorWithWhite:0.926 alpha:1.000];

    self.segement.drawsSegmentIndicatorGradientBackground = YES;

    self.segement.segmentIndicatorGradientTopColor = [UIColor colorWithRed:1.000 green:0.321 blue:0.387 alpha:1.000];
    self.segement.segmentIndicatorGradientBottomColor = [UIColor colorWithRed:1.000 green:0.321 blue:0.387 alpha:1.000];
    self.segement.segmentIndicatorAnimationDuration = 0.3;
    self.segement.layer.cornerRadius = 5;
    self.segement.titleTextColor = [UIColor blackColor];
    self.segement.titleFont = [UIFont systemFontOfSize:FONTMIN];
    self.segement.selectedTitleTextColor = [UIColor whiteColor];
    self.segement.selectedTitleFont = [UIFont systemFontOfSize:FONTMAX];
    self.segement.frame = CGRectMake(0, 0, WIDTH, 30);
    self.segement.selectedSegmentIndex = 0;
    [self.segement addTarget:self action:@selector(segementPressed:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segement];
    
    
//    创建主的滚动视图
    [self createScrollView];
    
    
}




/**
 *  创建最下面的滚动视图
 */
-(void)createScrollView{
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.mainScrollView.y += 30;
    self.mainScrollView.height -= 30;
    self.mainScrollView.delegate = self;
    self.mainScrollView.pagingEnabled = YES;
    [self.view addSubview:self.mainScrollView];
    
    
//    创建子视图
    [self createSubViewControllers];
    
    
    
}
/**
 *  创建子视图
 */
-(void)createSubViewControllers{
    CGFloat scrollW = self.mainScrollView.width;
    CGFloat scorllH = self.mainScrollView.height;
    
    
    self.search = [SearchViewController new];
    
    self.searchList = [ZHSearchListViewController new];
    
    
    
    [__vcArray arrayByAddingObjectsFromArray:@[self.search,self.searchList]];
    
    self.search.view.frame = CGRectMake(0, 0, scrollW, scorllH - _segement.height );
    
    __weak ZHSMainViewController * weakSelf = self;
    [self.search setShowVC:^(int idStr, NSString *name) {
        SearchDeatialController *sdvc = [[SearchDeatialController alloc]init];
        sdvc.title = name;
        sdvc.idStr = idStr;
        [weakSelf.navigationController pushViewController:sdvc animated:YES];
        
    }];
    self.searchList.view.frame = CGRectMake(scrollW, 0, scrollW, scorllH - _segement.height );
    
    [self.searchList setShowVC:^(id idStr, NSString *name) {
        ZHSubViewController *subvc = [[ZHSubViewController alloc]init];
        subvc.title = name;
        subvc.urlStr = [NSString stringWithFormat:topic_url,0,idStr];
        [subvc loadData];
        [weakSelf.navigationController pushViewController:subvc animated:YES];
        
    }];
    [self.mainScrollView addSubview:self.search.view];
    
    
    
    [self.mainScrollView addSubview:self.searchList.view];
    
    
    self.mainScrollView.contentSize = CGSizeMake(_buttons.count*WIDTH, 0);
    
    
    self.search.idStr = search_url;
    [self.search loadData];
    
    
}


/**
 *  segement的回调方法
 *
 *  @param segement <#segement description#>
 */
-(void)segementPressed:(NYSegmentedControl *)segement{
    if (segement.selectedSegmentIndex == 0) {

        self.search.idStr = search_url;
        [self.search loadData];
    }else if (segement.selectedSegmentIndex ==1 ){

        self.searchList.idStr = list_url;
        [self.searchList loadData];
    }
    [UIView animateWithDuration:0.3 animations:^{
        [_mainScrollView setContentOffset:CGPointMake(WIDTH * segement.selectedSegmentIndex, 0)];
    }];
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index = self.mainScrollView.contentOffset.x/WIDTH;
    if (index == 0) {
        self.search.idStr = search_url;
        [self.search loadData];

    }else if (index == 1){
        self.searchList.idStr = list_url;
        [self.searchList loadData];
        
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
