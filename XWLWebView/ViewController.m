//
//  ViewController.m
//  XWLWebView
//
//  Created by 夏文麟 on 16/9/28.
//
//

#import "ViewController.h"
#import "XWLWebView.h"
#import "WebViewController.h"
#import "WebViewController1.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *presentButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    presentButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:presentButton];
    [presentButton addTarget:self action:@selector(presentedVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *pushButton = [[UIButton alloc]initWithFrame:CGRectMake(200, 100, 100, 100)];
    pushButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:pushButton];
    [pushButton addTarget:self action:@selector(pushdVC) forControlEvents:UIControlEventTouchUpInside];
}
- (void)presentedVC{
    WebViewController *vc = [[WebViewController alloc]init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}
-(void)pushdVC{
    WebViewController1 *vc = [[WebViewController1 alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)returnToDocumentProgress:(NSString *)progress{
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
