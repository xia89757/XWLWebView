//
//  XWLWebView.h
//  XWLWebView
//
//  Created by 夏文麟 on 16/9/28.
//
//

//-9802  http://www.cnblogs.com/dsxniubility/p/4821184.html?utm_source=tuicool&utm_medium=referral
#import <UIKit/UIKit.h>
typedef enum _XWLWebCachePolicy{
    //
    XWLUseDefaultCachePolicy  = 0,
    // Tell the request not to read from the cache /永远重新请求
    XWLDoNotReadFromCacheCachePolicy = 1,
    // Ask the server if there is an updated version of this resource (using a conditional GET) ONLY when the cached data is stale /请询问服务器是否有此资源的更新版本（使用条件获取），只有当缓存的数据过期时
    XWLAskServerIfModifiedWhenStaleCachePolicy = 4,
    //Always ask the server if there is an updated version of this /总是问服务器是否有此资源的更新版本
    XWLAskServerIfModifiedCachePolicy = 8,
    // If cached data exists, use it even if it is stale. This means requests will not talk to the server unless the resource they are requesting is not in the cache /如果有缓存就使用缓存，否则请求网络
    XWLOnlyLoadIfNotCachedCachePolicy = 16,
}XWLCachePolicy;

@protocol progressDelegate <NSObject>
//回调不停的发送实时的进度
- (void)returnToDocumentProgress:(NSString *)progress;
@end


@interface XWLWebView : UIWebView
//可以通过此属性获取准确的进度 1为100％
@property(nonatomic,assign)CGFloat documentProgressFloat;
//之前阅读的进度，从这里开始。
@property(nonatomic,assign)CGFloat ProgressFloat;
@property(nonatomic,assign)id<progressDelegate> progressDelgate;
- (void)loadHTMLStr:(NSString *)string defaultCachePolicy:(XWLCachePolicy)defaultCachePolicy;

@end
