//
//  ZHSearchResultViewController.m
//  bantang
//
//  Created by MS on 16-1-19.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHSearchResultViewController.h"
#import "NYSegmentedControl.h"
#import "SearchDeatialController.h"
#import "ZHSubViewController.h"
#import "ZHProductViewController.h"


@interface ZHSearchResultViewController ()@property(nonatomic,strong)NSArray *vcArray;
@property(nonatomic,strong)NSArray *buttons;
@property(nonatomic,strong)NYSegmentedControl *segement;
@property(nonatomic,strong)UIScrollView *mainScrollView;

@property(nonatomic,strong)ZHProductViewController *product;
@property(nonatomic,strong)ZHSubViewController *subView;
@property(nonatomic,strong)SearchDeatialController *detail;

@property(nonatomic,copy)NSString  *inputText;



@end

@implementation ZHSearchResultViewController


-(void)viewDidAppear:(BOOL)animated{
    self.view.y += 64;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self createSegement];

    
    
}


/**
 *  创建一个segement
 */
-(void)createSegement{
    _buttons = @[@"单品",@"清单",@"帖子"];
    
    
    self.segement.selectedSegmentIndex = 0;
    self.segement = [[NYSegmentedControl alloc]initWithItems:_buttons];
    self.segement.borderColor = [UIColor colorWithWhite:0.926 alpha:1.000];
    self.segement.frame = CGRectMake(0, 0, WIDTH, 30);
    self.segement.drawsSegmentIndicatorGradientBackground = YES;
    
    self.segement.segmentIndicatorGradientTopColor = [UIColor colorWithRed:1.000 green:0.321 blue:0.387 alpha:1.000];
    self.segement.segmentIndicatorGradientBottomColor = [UIColor colorWithRed:1.000 green:0.321 blue:0.387 alpha:1.000];
    self.segement.segmentIndicatorAnimationDuration = 0.3;
    self.segement.layer.cornerRadius = 5;
    self.segement.titleTextColor = [UIColor blackColor];
    self.segement.titleFont = [UIFont systemFontOfSize:FONTMIN];
    self.segement.selectedTitleTextColor = [UIColor whiteColor];
    self.segement.selectedTitleFont = [UIFont systemFontOfSize:FONTMAX];

    self.segement.selectedSegmentIndex = 0;
    [self.segement addTarget:self action:@selector(segementPressed:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segement];
    
    
    //    创建主的滚动视图
    [self createScrollView];
    
    
}
#pragma mark - uisearchBar 的代理方法
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *inputText = searchController.searchBar.text;
    
    
    
    [_detail loadSearchData:inputText];
    
}






/**
 *  创建最下面的滚动视图
 */
-(void)createScrollView{
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.mainScrollView.y += CGRectGetMaxY(_segement.frame);
    self.mainScrollView.height -= CGRectGetHeight(_segement.frame);
    self.mainScrollView.delegate = self;
    self.mainScrollView.pagingEnabled = YES;
    [self.view addSubview:self.mainScrollView];
    
    
    //    创建子视图
    [self createSubViewControllers];
    
    
    
}
/**
 * 创建子视图
 */
-(void)createSubViewControllers{
    CGFloat scrollW = self.mainScrollView.width;
    CGFloat scorllH = self.mainScrollView.height;
    
    
    SearchDeatialController *detail = [SearchDeatialController new];
    detail.view.frame = CGRectMake(0, 0, scrollW, scorllH);
    _detail = detail;
    [self.mainScrollView addSubview:detail.view];
    

    ZHSubViewController *subView = [ZHSubViewController new];
    subView.view.frame = CGRectMake(scrollW, 0, scrollW, scorllH);
    _subView = subView;
    [self.mainScrollView addSubview:subView.view];
    
    
    ZHProductViewController *product = [ZHProductViewController new];
    product.view.frame = CGRectMake(scrollW * 2, 0, scrollW, scorllH);
    _product = product;
    [self.mainScrollView addSubview:product.view];
    
    
    [_vcArray arrayByAddingObjectsFromArray:@[detail,subView,product]];
    
    self.mainScrollView.contentSize = CGSizeMake(_buttons.count * WIDTH, 0);
    

    
    detail.keyword = _inputText;
    
    
    
    
    
    
}




-(void)segementPressed:(NYSegmentedControl *)segement{
    
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
