//
//  AgreementViewController.m
//  sebot
//
//  Created by yulei on 16/6/20.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AgreementViewController.h"
#import "AFHttpClient+About.h"


@interface AgreementViewController ()

@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"Agreement", nil)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self request];
}
-(void)request{
    
//    [[AFHttpClient sharedAFHttpClient]xieyiWithuserid:@"1"token:@"1" complete:^(ResponseModel * model) {
//        
//    }];
//    [[AFHttpClient sharedAFHttpClient]POST:@"sebot/common/forward/" parameters:@{} result:^(ResponseModel *model) {
//        
//    }];
    
    
    

}






- (void)setupView
{
    [super setupView];
    
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    UIWebView * web = [[UIWebView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 727 * W_Hight_Zoom)];
    NSString * str =  BASE_URL;
    
    NSString * str1 = @"/sebot/common/forward?&rp={\"userid\":\"1\",\"token\":\"1\",\"objective\":\"agreement\",\"action\":\"agreement\",\"data\":{}}";
    str = [str stringByAppendingString:str1];
    
    NSString * contentStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url =[NSURL URLWithString:contentStr];
    [web loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:web];
    
}





@end
