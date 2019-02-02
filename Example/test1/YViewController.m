//
//  YViewController.m
//  test1
//
//  Created by wzy2010416033@163.com on 02/02/2019.
//  Copyright (c) 2019 wzy2010416033@163.com. All rights reserved.
//

#import "YViewController.h"
#import <WebKit/WebKit.h>

@interface YViewController () <WKNavigationDelegate>
@property (nonatomic) WKWebView *web1;

@end

@implementation YViewController

- (IBAction)present:(id)sender {
    [self.view addSubview:self.web1];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"0202-test1" ofType:@"txt"];
    NSData *responsedata = [[NSData alloc] initWithContentsOfFile:path];
    NSString *htmlStr = [[NSString alloc] initWithData:responsedata encoding:NSUTF8StringEncoding];
    htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"\\r" withString:@""];
    
    htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];
    htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    [self.web1 loadHTMLString:htmlStr baseURL:nil];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"didFinishNavigation");
}
- (WKWebView *)web1 {
    if (!_web1) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.allowsInlineMediaPlayback = YES;
        _web1 = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
        _web1.scrollView.bounces = NO;
        _web1.navigationDelegate = self;
        _web1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        if (@available(iOS 11.0, *)) {
            [_web1.scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
    }
    return _web1;
}

@end
