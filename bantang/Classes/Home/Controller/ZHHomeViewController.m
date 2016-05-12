//
//  ZHHomeViewController.m
//  bantang
//
//  Created by MS on 15-12-28.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#warning 取消mj刷新的上拉刷新可以让他直接不用table不用mj刷新,还有要取消弹簧效果就好了.


#import "ZHHomeViewController.h"
#import "ZHBtnScrollView.h"
#import "MJRefresh.h"
#import "NetAPI.h"
#import "ZHBannerModel.h"
#import "ZHTopicModel.h"
#import "MJExtension.h"
#import "UIView+Extension.h"
#import "UIButton+Size.h"
#import "UIButton+WebCache.h"
#import "UIBarButtonItem+Extension.h"
#import "ZHSubViewController.h"
#import "ZHTopPicCell.h"
#import "UIImageView+WebCache.h"
#import "ZHSubViewController.h"
#import "Masonry.h"
#import "SDCycleScrollView.h"
#import "ZHWebViewController.h"
#import "KVNProgress.h"
#import "ZHSMainViewController.h"
#import "ZHProductViewController.h"




#define CATEGORY  @[@"最新",@"文艺",@"礼物",@"指南",@"爱美",@"设计",@"吃货",@"格调",@"厨房",@"上班族",@"学生党",@"聚会",@"节日",@"宿舍"]
#define IVHEIGHT     WIDTH/1.875


//    0.获取沙盒中的数据库的名字
#define  fileName  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"firstPage.text"]
@interface ZHHomeViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate>{
    UIImageView *_rootImageView;
    __weak UITableView * _bottomTableView;
    
}



/**
 *  用来存放btn的
 */
@property(nonatomic,strong)NSMutableArray *btnArray;
/**
 *  用来存放视图
 */
@property(nonatomic,strong)NSMutableArray *vcArray;

/**
 *  scrollview的图片数组
 */
@property(nonatomic,strong)NSMutableArray *scPicArr;

@property(nonatomic,strong)UIScrollView *bottomScrollView;





@end

@implementation ZHHomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.navigationController.navigationBar.alpha = 0;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _btnArray = [NSMutableArray new];
    _vcArray = [NSMutableArray new];
    _scPicArr = [NSMutableArray new];
    // Do any additional setup after loading the view.
//    设置导航栏内容
//    self.automaticallyAdjustsScrollViewInsets = NO;

    [self setNavigationBar];
//    创建最底下一层的scrollView
    [self createScrollView];
    self.scrollView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
//    开始下拉刷新
    [self.scrollView.header beginRefreshing];
    
    //添加监听者
//    [self.scrollView addObserver: self forKeyPath: @"contentOffset" options: NSKeyValueObservingOptionNew context: nil];
 
    
    //    开始请求的时候打开蒙版，请求数据完毕的时候移除蒙版
    [KVNProgress showWithStatus:@"加载数据ing"];
    
}

#pragma mark - 导航栏按钮回调
-(void)searchClick:(UIBarButtonItem *)bbi{
    ZHSMainViewController *searchVC = [ZHSMainViewController new];
    [self.navigationController pushViewController:searchVC animated:YES];
}



/**
 *  监听回调
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
////    
//    CGFloat offset = self.scrollView.contentOffset.y;
////    CGFloat delta = offset / (_topScrollView.height - NAVBARHEIGHT *2 );
//    NSLog(@"%.2f",offset);
////    如果移动到这个点,就打开tableView的滚动
//    if (offset>136) {
//        for (ZHSubViewController *subVC in _vcArray) {
//            subVC.tableView.scrollEnabled = YES;
//        }
//    }
//
//    NSLog(@"%.2f",delta);
    
//    delta = MAX(0, delta);
//    self.navigationController.navigationBar.alpha = MIN(1, delta);
    
}


/**
 *  设置navigationbar的内容
 */
-(void)setNavigationBar{
    
//    添加左边的分享按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem  itemWithImageName:@"home_search_icon" highImageName:@"home_search_icon" target:self action:@selector(searchClick:)];
    
}


/**
 *  加载数据
 */
-(void)loadData{

    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager new];
    
//        1.先从缓存里面加载,如果缓存里面没有在发送网络请求
//    有缓存
    if (fileName){
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:fileName];
        [self analysisData:dic[@"data"]];
        
    }
    
    [manager POST:[NSString stringWithFormat:latest_url,0] parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
//        数据请求之后让这个文件写入本地
        [responseObject writeToFile:fileName atomically:YES];
        
        NSDictionary *data = responseObject[@"data"];
        //储存本地数据
        
        //将数据置空
        [_scPicArr removeAllObjects];
        //解析数据
        [self analysisData:data];
        
        
        //移除蒙版
        [KVNProgress dismiss];
        //停止刷新
        [self.scrollView.header endRefreshing];
//        在这里让下面的tableView调用刷新的函数,让tableView请求数据
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",[error description]);
        [self.scrollView.header endRefreshing];
        [KVNProgress showErrorWithStatus:@"网络链接错误"];
    }];

    
}
/**
 *  解析数据
 */
-(void)analysisData:(NSDictionary *)data{
    
    for (NSDictionary *dic in data[@"banner"]) {
        [_scPicArr addObject: [ZHBannerModel objectWithKeyValues:dic]];
        
    }
    //设置图片
    [self setScrollViewImage];
}



-(void)setScrollViewImage{
    
    NSMutableArray *tmpArr = [NSMutableArray new];
    for (ZHBannerModel *banner in _scPicArr) {
        [tmpArr addObject:banner.photo];
    }
    
    [self.topScrollView setImageURLStringsGroup:tmpArr];
    self.topScrollView.delegate = self;
    self.topScrollView.backgroundColor = [UIColor redColor];
    self.topScrollView.dotColor = [UIColor whiteColor];
    self.topScrollView.placeholderImage = [UIImage imageNamed:@"default_user_loading_icon"];
    self.topScrollView.autoScrollTimeInterval = 3.0;
    
    
    
}


/**
 *  创建最底层的scrollView
 */
-(void)createScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    self.scrollView.y = -48;
    self.scrollView.delegate = self;
    
    [self.view addSubview:self.scrollView];
    //创建tableView底下的scrollView
    _bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT + 240)];
    _bottomScrollView.delegate = self;
    _bottomScrollView.pagingEnabled = YES;

    
    [self.scrollView addSubview:_bottomScrollView];

    
    
//    创建头部视图
    [self createTopView];
    
}



/**
 *  创建顶部的视图
 */
-(void)createTopView{
//    将这些添加到view上和添加到scrollview 上
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 240)];
    SDCycleScrollView *topScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, IVHEIGHT)];
    self.topScrollView = topScrollView;
    
    ZHBtnScrollView *btnScrollView = [[ZHBtnScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topScrollView.frame), WIDTH, 25)];
    
    self.btnScrollView = btnScrollView;
    _rootImageView = [[UIImageView alloc]init];
    [self.scrollView addSubview:view];
    
    
    [self.btnScrollView addSubview:_rootImageView];
    [view addSubview:topScrollView];

    [view addSubview:btnScrollView];

    
//    创建下面视图
    [self createBottomView];
    
    
}



/**
 *  创建视图UI
 */
-(void)createBottomView{
    int btnoffset = 0;
    for (int i = 0; i<CATEGORY.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:CATEGORY[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:FONTMIN];
        CGSize size = [UIButton sizeOfLabelWithCustomMaxWidth:WIDTH systemFontSize:FONTMIN andFilledTextString:CATEGORY[i]];
        btn.frame = CGRectMake(size.width+btnoffset, 0, size.width, size.height);
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn addTarget:self action:@selector(itemButtonSender:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnScrollView addSubview:btn];
        btnoffset = CGRectGetMaxX(btn.frame);

        self.btnScrollView.contentSize = CGSizeMake(size.width+btnoffset, size.height);
        [_btnArray addObject:btn];

//        创建tableView
        ZHSubViewController *subVC = [ZHSubViewController new];
        subVC.view.frame = CGRectMake(self.view.width * i,CGRectGetMaxY(self.btnScrollView.frame), self.view.width, self.view.height);
//        subVC.view.y = WIDTH == 375? CGRectGetMaxY(self.btnScrollView.frame)+25:CGRectGetMinY(self.btnScrollView.frame)-2;
        [self.bottomScrollView addSubview:subVC.view];
    
        subVC.showSubViews = ^(UIViewController *vc){
            
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        [_vcArray addObject:subVC];
        
        if (i == 0) {
            btn.selected = YES;
            _rootImageView.frame = CGRectMake(25, self.btnScrollView.height - 2, btn.width, 2);
            _rootImageView.image = [UIImage imageNamed:@"nar_bgbg"];
            subVC.urlStr = latest_url;
            
            [subVC loadData];
            
            
        }

        
    }
    
    
    self.bottomScrollView.contentSize = CGSizeMake(_vcArray.count * WIDTH, HEIGHT);
    self.scrollView.contentSize = CGSizeMake(WIDTH, self.scrollView.height+self.topScrollView.height + self.btnScrollView.height - 44 - 30);
    
}


/**
 *  选项卡的点击时间切换视图
 *
 *  @param itemBtn <#itemBtn description#>
 */
-(void)itemButtonSender:(UIButton *)itemBtn{
    for (UIButton *theBtn in _btnArray) {
        theBtn.selected = NO;
    }
    itemBtn.selected = YES;
    
    NSInteger index = [_btnArray indexOfObject:itemBtn];
    
    NSArray *arr = @[latest_url,literature_url,gifts_url,guide_url,dressing_url,design_url,eat_url,style_url,kitchen_url,working_url,students_url,party_url,holiday_url,studentHome_url];
    
    ZHSubViewController *vc = _vcArray[index];
    vc.urlStr = arr[index];
    [vc loadData];
    
    [UIView animateWithDuration:0.3 animations:^{
        if (index == 0) {
            _rootImageView.frame = CGRectMake(25, self.btnScrollView.height - 2, itemBtn.width, 2);
            _rootImageView.image = [UIImage imageNamed:@"nar_bgbg"];
            
        }else{
            //              获取当前按钮的前一个按钮
            UIButton *prebtn = _btnArray[index - 1];
            //            获取前一个按钮的偏移量
            float offsetX = CGRectGetMinX(prebtn.frame)-25;
            //            将顶部选项卡的位置显示到这个位置
            [_btnScrollView scrollRectToVisible:CGRectMake(offsetX, 0, _btnScrollView.width, _btnScrollView.height) animated:YES];
            //            将下方标示线显示到这个按钮的下方
            _rootImageView.frame = CGRectMake(CGRectGetMinX(itemBtn.frame), _btnScrollView.height-2, itemBtn.width, 2);
            
        }
        _bottomScrollView.contentOffset = CGPointMake(WIDTH *index, 0);
        
    }];
    
    
    
    
}

#pragma mark - scrollView的代理方法

/**
 *  scrollView的代理,控制tableView的滚动
 *
 *  @param scrollView <#scrollView description#>
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView !=self.bottomScrollView) {
        return ;
    }
    int index = scrollView.contentOffset.x/scrollView.width;
    
    NSArray *arr = @[latest_url,literature_url,gifts_url,guide_url,dressing_url,design_url,eat_url,style_url,kitchen_url,working_url,students_url,party_url,holiday_url,studentHome_url,carefully_url];
    
    ZHSubViewController *vc = _vcArray[index];
    vc.urlStr = arr[index];
    [vc loadData];
    
    UIButton *itemBtn = _btnArray[index];
    for (UIButton *theBtn in _btnArray) {
        theBtn.selected = NO;
    }
    itemBtn.selected = YES;
    [itemBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    [UIView animateWithDuration:0.3 animations:^{
        if (index == 0) {
            [_rootImageView setFrame:CGRectMake(25, self.btnScrollView.height - 2,itemBtn.width , 2)];
            [_rootImageView setImage:[UIImage imageNamed:@"account_logout_button@2x.png"]];
        }else {
            UIButton *preBtn = _btnArray[index - 1];
            float offsetX = CGRectGetMinX(preBtn.frame) - 25;
            [_btnScrollView scrollRectToVisible:CGRectMake(offsetX, 0, CGRectGetWidth(_btnScrollView.frame), CGRectGetHeight(_btnScrollView.frame)) animated:YES];
            [_rootImageView setFrame:CGRectMake(CGRectGetMinX(itemBtn.frame), CGRectGetHeight(_btnScrollView.frame) - 2,itemBtn.frame.size.width , 2)];
        }
    }];

    
}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.y >= 130) {
//        [self.view addSubview:self.btnScrollView];
//        self.btnScrollView.frame = CGRectMake(0, 64, self.view.frame.size.width, 44);
//    }else{
//        [self.scrollView addSubview:self.btnScrollView];
//        self.btnScrollView.frame = CGRectMake(0, 130, self.view.frame.size.width, 44);
//    }
//}
#pragma mark - topscrollView的代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {

    ZHBannerModel *bm = _scPicArr[index];
    ZHSubViewController *subView = [ZHSubViewController new];
    if ([bm.type isEqualToString:@"topic_list"]) {
        

        subView.urlStr = [topic_list_url stringByAppendingString:bm.extend];
        subView.title = bm.title;
        subView.tableView.footer = nil;
        
        [subView loadData];
        subView.showSubViews = ^(UIViewController *vc){
            
            [self.navigationController pushViewController:vc animated:YES];
        };

        [self.navigationController pushViewController:subView animated:YES];

    }else if ([bm.type isEqualToString:@"webview"]){
        ZHWebViewController *webView = [[ZHWebViewController alloc]init];
        webView.urlStr = bm.extend;
        webView.title = bm.title;
        [self.navigationController pushViewController:webView animated:YES];
        
        
    }else if ([bm.type isEqualToString:@"product_list"]){
        ZHProductViewController *product = [ZHProductViewController new];
        product.urlStr = [product_list_url stringByAppendingString:bm.extend];
        product.title = bm.title;
        [self.navigationController pushViewController:product animated:YES];
        
        
    }
    
    
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
