//
//  RegistViewController.m
//  sebot
//
//  Created by czx on 16/6/16.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()
@property (nonatomic,strong)UIButton * achieveSecurityBtn;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = NEW_GRAY_COLOR;
    [UINavigationBar appearance].barTintColor=RED_COLOR;
    [self setNavTitle:@"注册"];
    [self initUserface];
}
-(void)initUserface{
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 68 * W_Hight_Zoom, 375 * W_Wide_Zoom, 200 * W_Hight_Zoom)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    NSArray * namearray = @[NSLocalizedString(@"phoneNumber", nil),NSLocalizedString(@"yanzhengma", nil),NSLocalizedString(@"password", nil),NSLocalizedString(@"surePassword", nil)];
    for (int i = 0 ; i < 4 ; i++ ) {
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 50 * W_Hight_Zoom + i * 50 * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        lineLabel.backgroundColor = GRAY_COLOR;
        [topView addSubview:lineLabel];
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 15 * W_Hight_Zoom + i * 50 * W_Hight_Zoom, 80 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
        nameLabel.text = namearray[i];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.textAlignment = NSTextAlignmentRight;
        nameLabel.font = [UIFont systemFontOfSize:14];
        [topView addSubview:nameLabel];
    }
    
    _achieveSecurityBtn = [[UIButton alloc]initWithFrame:CGRectMake(260 * W_Wide_Zoom, 60 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _achieveSecurityBtn.backgroundColor = RED_COLOR;
    [_achieveSecurityBtn setTitle:NSLocalizedString(@"getSecurity", nil) forState:UIControlStateNormal];
    _achieveSecurityBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_achieveSecurityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _achieveSecurityBtn.layer.cornerRadius = 5;
    [topView addSubview:_achieveSecurityBtn];
    
    UIButton * registBtn = [[UIButton alloc]initWithFrame:CGRectMake(15 * W_Wide_Zoom, 300 * W_Hight_Zoom, 345 * W_Wide_Zoom, 45 * W_Hight_Zoom)];
    registBtn.backgroundColor = RED_COLOR;
    [registBtn setTitle:NSLocalizedString(@"regist", nil) forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registBtn.layer.cornerRadius = 5;
    [self.view addSubview:registBtn];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(65 * W_Wide_Zoom, 360 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    label.textColor = [UIColor grayColor];
    label.text =@"点击'注册'按钮,代表您已阅读并同意";
    label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:label];
    
    UIButton * xieyiBtn = [[UIButton alloc]initWithFrame:CGRectMake(230 * W_Wide_Zoom, 365 * W_Hight_Zoom, 100 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
    [xieyiBtn setTitle:@"注册协议" forState:UIControlStateNormal];
    [xieyiBtn setTitleColor:RED_COLOR forState:UIControlStateNormal];
    xieyiBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:xieyiBtn];
    

}

@end
