//
//  ZHWebViewController.m
//  bantang
//
//  Created by MS on 16-1-10.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHWebViewController.h"
#import "KVNProgress.h"
@interface ZHWebViewController ()<UIWebViewDelegate>{
    
    UIWebView *_webView;
    
    
}


@property (strong,nonatomic)NSString *currentURL;
@property (strong,nonatomic)NSString *currentTitle;
@property (strong,nonatomic)NSString *currentHTML;
@end

@implementation ZHWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    

    _webView.height -= 64;
    _webView.delegate = self;
    [self.view addSubview:_webView];
//    禁用拖拽时的反弹效果
    [(UIScrollView *)[[_webView  subviews]firstObject] setBounces:NO];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5]];
    
    
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [KVNProgress showWithStatus:@"loading"];
    
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [KVNProgress dismiss];
    
    
//    self.navigationItem.leftBarButtonItem.enabled = _webView.canGoBack;
//    self.forawrdItem.enabled = _webView.canGoForward;
    
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title
    
//    self.currentURL = webView.request.URL.absoluteString; // 获取当前页面的网址
//    NSLog(@"title-%@--url-%@--",self.title,self.currentURL);
    
//    NSString *lJs = @"document.documentElement.innerHTML";//获取当前网页的html
//    self.currentHTML = [webView stringByEvaluatingJavaScriptFromString:lJs];
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [KVNProgress showErrorWithStatus:@"加载出错"];
}

/**
 *
 *  // 如果返回NO，代表不允许加载这个请求
 *  @param webView
 *  @param request
 *  @param navigationType
 *
 *  @return
 */
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return  YES;
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
