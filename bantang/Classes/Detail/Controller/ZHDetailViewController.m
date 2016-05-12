//
//  ZHDetailViewController.m
//  bantang
//
//  Created by MS on 16-1-4.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHDetailViewController.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "ZHDataModel.h"
#import "MJExtension.h"
#import "ZHListModel.h"
#import "UIImageView+WebCache.h"
#import "ZHDetailTableViewCell.h"
#import "ZHRecommendTableViewController.h"
#import "ZHGoodsDetailViewController.h"
#import "ZHWebViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UMSocial.h"
#import "KVNProgress.h"

#define DETAILCELL @"ZHDetailTableViewCell"
@interface ZHDetailViewController ()<UITableViewDelegate,UITableViewDataSource, UMSocialUIDelegate>{
    NSMutableArray *_dataArr;
    NSMutableArray *_productArr;
    NSMutableArray *_picArr;
    NSMutableArray *_likes;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIImageView *preIV;
@property (strong, nonatomic) UILabel *titleLabel;


@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIButton *recommendBtn;


@end

@implementation ZHDetailViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"买买精选";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray new];
    _productArr = [NSMutableArray new];
    _picArr = [NSMutableArray new];
    _likes = [NSMutableArray new];
    // Do any additional setup after loading the view from its nib.
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        加载数据
        [self loadData];
    }];
    
    
    
    //添加监听者
//    [self.tableView addObserver: self forKeyPath: @"contentOffset" options: NSKeyValueObservingOptionNew context: nil];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ZHDetailTableViewCell" bundle:nil] forCellReuseIdentifier:DETAILCELL];
    
    
    [_tableView.header beginRefreshing];
    //创建头视图
    [self createHeaderView];
    
    
    //    设置导航栏右边为分享按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"share_item_icon" highImageName:@"share_item_icon" target:self action:@selector(shareBtnClick:)];
    
    //    开始请求的时候打开蒙版，请求数据完毕的时候移除蒙版
    [KVNProgress showWithStatus:@"loading"];
    
    
}

#pragma mark - 友盟分享

-(void)shareBtnClick:(UIBarButtonItem *)bbi{
    if (_dataArr.count == 0) {
        return;
    }
    ZHDataModel *dataModel = _dataArr[0];
    UIImageView *iv = [[UIImageView alloc]init];
    [iv sd_setImageWithURL:[NSURL URLWithString:dataModel.pics]];
    
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56935b7767e58eb6b50004e0" shareText:[NSString stringWithFormat:@"%@\n%@",dataModel.title,dataModel.share_url] shareImage:iv.image shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToDouban,UMShareToEmail,UMShareToSms,UMShareToFacebook,UMShareToTwitter,nil] delegate:self];
    
}

//完成后获取友盟数据相应
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response;{
    if (response.responseCode == UMSResponseCodeSuccess) {
        [KVNProgress showSuccessWithStatus:@"分享成功"];
    }
}



/**
 *  创建头视图
 */
-(void)createHeaderView{

    _headerView = [[UIView alloc]init];
    _headerView.backgroundColor = [UIColor whiteColor];
    _preIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH/2)];
    [_headerView addSubview:_preIV];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _preIV.height, WIDTH - 20, 20)];
    _titleLabel.font = [UIFont systemFontOfSize:FONTMAX];
    _titleLabel.textColor = [UIColor lightGrayColor];
    [_headerView addSubview:_titleLabel];
    
    _descLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_titleLabel.frame), WIDTH - 20, 20)];
    _descLabel.numberOfLines = 0;
    _descLabel.textColor = [UIColor lightGrayColor];
    _descLabel.font = [UIFont systemFontOfSize:FONTMIN];
    [_headerView addSubview:_descLabel];
    

    
    
    
}

//设置为tableView的头视图,计算header的大小
-(void)headerViewFrame:(ZHDataModel *)dataModel{
    
    CGSize size = [dataModel.desc boundingRectWithSize:CGSizeMake(WIDTH - 22, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONTMIN]} context:nil].size;
    _descLabel.height = size.height;
    _headerView.frame = CGRectMake(0, 0, WIDTH, _preIV.height+_titleLabel.height+_descLabel.height);
    self.tableView.tableHeaderView = _headerView;
    
}


/**
 *  加载数据
 */
-(void)loadData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:detail_url,self.idStr]parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *dataDic = responseObject[@"data"];
        
        ZHDataModel *dataModel = [ZHDataModel new];
        [dataModel setValuesForKeysWithDictionary:dataDic];
        dataModel.pics= dataDic[@"pic"];

        
        [_dataArr addObject:dataModel];
        
        for (NSDictionary *dic in dataDic[@"product"]) {
            [_productArr addObject:[ZHDataModel objectWithKeyValues:dic]];
        }
        
//        设置头视图元素
        [self setHeaderViewItem:_dataArr[0]];
        [_tableView.header endRefreshing];
        [_tableView reloadData];
        [KVNProgress dismiss];
        
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error :%@",[error description]);
        [_tableView.header endRefreshing];
        [KVNProgress dismiss];
    }];
}
/**
 *  设置头视图元素
 */
-(void)setHeaderViewItem:(ZHDataModel *)dataModel{
    //    设置为tableView的头视图
    [self headerViewFrame:dataModel];
    [self.preIV sd_setImageWithURL:[NSURL URLWithString:dataModel.pics]];
    self.titleLabel.text = dataModel.title;
    self.descLabel.text = dataModel.desc;

}




#pragma mark - tableView的代理方法

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ZHDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DETAILCELL forIndexPath:indexPath];

    cell.dataModel = _dataArr[0];
    cell.productModel = _productArr[indexPath.row];
    cell.goodIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"good%zd",indexPath.row + 1]];
    [cell setBuyWebView:^(NSString *urlStr) {
        ZHWebViewController *webView = [ZHWebViewController new];
        webView.urlStr = urlStr;
        [self.navigationController pushViewController:webView animated:YES];
    }];
    
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _productArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHDataModel *dataModel = _productArr[indexPath.row];;
    return  [ZHDetailTableViewCell  heightForRow:dataModel];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _recommendBtn.frame = CGRectMake(0, CGRectGetMaxY(_descLabel.frame)+5, WIDTH, 50);
    [_recommendBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_recommendBtn setTitle:@"点击查看用户推荐" forState:UIControlStateNormal];
    _recommendBtn.backgroundColor = [UIColor colorWithWhite:0.917 alpha:1.000];
    [_recommendBtn addTarget:self action:@selector(recommendBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    return _recommendBtn;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}

/**
 *  组头视图的按键回调
 *
 *  @param btn <#btn description#>
 */
-(void)recommendBtnClick:(UIButton *)btn{
    ZHRecommendTableViewController *recommend = [ZHRecommendTableViewController new];
    
    recommend.product = _productArr;
    recommend.dataModel = _dataArr;
    recommend.idStr = self.idStr;
//    加载第二页数据
    [recommend loadData];
    
    
    [self.navigationController pushViewController:recommend animated:YES];
    
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZHDataModel *dataModel = _productArr[indexPath.row];;
    ZHGoodsDetailViewController *goodsVc = [ZHGoodsDetailViewController new];

    goodsVc.idStr = [NSString stringWithFormat:@"%@",dataModel.id];
    
    [self.navigationController pushViewController:goodsVc animated:YES];
    
    
    
    
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    
//    CGFloat offset = self.tableView.contentOffset.y + 20;
//    NSLog(@"%.2f",offset);
//    CGFloat delta = offset / (_preIV.height+_titleLabel.height);
//    NSLog(@"delta:%.2f",delta);
//    delta = MAX(0.01, delta);
//    self.navigationController.navigationBar.alpha = MIN(1, delta);
//    
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
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
