//
//  AgreementViewController.m
//  sebot
//
//  Created by yulei on 16/6/20.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()

@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"Agreement", nil)];
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView
{
    [super setupView];
    
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    UIWebView * web = [[UIWebView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 727 * W_Hight_Zoom)];
    NSString * str =  [AppUtil getServerTest];
    str = [str stringByAppendingString:@"s/agreement/article.jsp"];
    NSURL * url = [NSURL URLWithString:str];
    [web loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:web];
    
}

@end
