//
//  WebViewController.m
//  XWLWebView
//
//  Created by 夏文麟 on 16/9/28.
//
//

#import "WebViewController.h"
#import "XWLWebView.h"
@interface WebViewController ()<progressDelegate>{
    XWLWebView *webView;
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    webView = [[XWLWebView alloc]init];
    [self.view addSubview:webView];
    webView.progressDelgate = self;
    webView.ProgressFloat = 0.31;
    [webView loadHTMLStr:@"https://github.com/" defaultCachePolicy:XWLOnlyLoadIfNotCachedCachePolicy];
}
- (void)returnToDocumentProgress:(NSString *)progress{
    NSLog(@"进度为%@",progress);
    NSLog(@"返回键%f",webView.documentProgressFloat);
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
