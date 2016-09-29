//
//  XWLWebView.m
//  XWLWebView
//
//  Created by 夏文麟 on 16/9/28.
//
//

#import "XWLWebView.h"
#define webHeight [UIScreen mainScreen].bounds.size.height
#define webWidth [UIScreen mainScreen].bounds.size.width
@interface XWLWebView()<UIWebViewDelegate,UIScrollViewDelegate>
{
    CGFloat documentHeight;
    CGFloat tmpProGress;
}
@end

@implementation XWLWebView
//自定义大小，构造方法
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        //设置UI
        self.scalesPageToFit = YES;
        self.delegate = self;
        self.scrollView.delegate = self;
        self.scrollView.bounces = NO;
    }
    return self;
}
//一键构造方法
-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, webWidth, webHeight);
        //设置UI
        self.scalesPageToFit = YES;
        self.delegate = self;
        self.scrollView.delegate = self;
        self.scrollView.bounces = NO;
    }
    return self;
}

- (void)loadHTMLStr:(NSString *)string defaultCachePolicy:(XWLCachePolicy)cachePolicy{
    NSURL *fileUrl = [NSURL URLWithString:string];
    self.documentProgressFloat = _ProgressFloat;
    NSURLRequest *fileRequest;
    switch (cachePolicy) {
        case XWLUseDefaultCachePolicy:
            fileRequest = [NSURLRequest requestWithURL:fileUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
            break;
        case XWLDoNotReadFromCacheCachePolicy:
            fileRequest = [NSURLRequest requestWithURL:fileUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
            break;
        case XWLAskServerIfModifiedCachePolicy:
            fileRequest = [NSURLRequest requestWithURL:fileUrl cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:20];
            break;
        case XWLOnlyLoadIfNotCachedCachePolicy:
            fileRequest = [NSURLRequest requestWithURL:fileUrl cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:20];
            break;
        default:
            break;
    }
     [self loadRequest:fileRequest];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //防止未加载完成前，提前计算了进度
    if(webView.isLoading) return;
    NSLog(@"%f",webView.scrollView.contentSize.height);
    documentHeight = webView.scrollView.contentSize.height;
    //跳转到初始化的阅读百分比
    if (_ProgressFloat<webView.scrollView.bounds.size.height/documentHeight) {
        _ProgressFloat=webView.scrollView.bounds.size.height/documentHeight;
    }
    CGFloat  progressPercent=documentHeight*_ProgressFloat-webView.scrollView.bounds.size.height;
    [webView.scrollView setContentOffset:CGPointMake(0, progressPercent) animated:YES];
    NSInteger htmlheight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] integerValue];
    NSLog(@"htmlheight%ld",(long)htmlheight);
    NSInteger height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] intValue];
    NSLog(@"height%ld",(long)height);
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [self documentProgress:scrollView];
}

-(void)documentProgress:(UIScrollView *)scrollView{
    if (((scrollView.contentOffset.y+scrollView.bounds.size.height)/documentHeight)>tmpProGress) {
        tmpProGress = (scrollView.contentOffset.y+scrollView.bounds.size.height) /documentHeight;
    }
    [self.progressDelgate returnToDocumentProgress:[NSString stringWithFormat:@"%2.0f%%",(scrollView.contentOffset.y+scrollView.bounds.size.height) /documentHeight*100]];
    self.documentProgressFloat = _ProgressFloat>tmpProGress?_ProgressFloat:tmpProGress;
}

@end
