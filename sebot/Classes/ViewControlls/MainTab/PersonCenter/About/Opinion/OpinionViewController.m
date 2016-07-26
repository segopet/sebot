//
//  OpinionViewController.m
//  sebot
//
//  Created by yulei on 16/6/20.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "OpinionViewController.h"

@interface OpinionViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    
    
}
@property (nonatomic,strong)UITextView * topTextfield;
@property (nonatomic,strong)UITextField * downTextfield;
@property (nonatomic,strong)UILabel * placeholderLabel;

@end


@implementation OpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"Opinion", nil)];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView
{
    [super setupView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self showBarButton:NAV_RIGHT title:@"发送" fontColor:[UIColor whiteColor]];
    _topTextfield = [[UITextView alloc]initWithFrame:CGRectMake(20 * W_Wide_Zoom, 70 * W_Hight_Zoom, 335 * W_Wide_Zoom, 120 * W_Hight_Zoom)];
    _topTextfield.backgroundColor = LIGHT_GRAY_COLOR;
    _topTextfield.textAlignment = NSTextAlignmentLeft;
    _topTextfield.font = [UIFont systemFontOfSize:13];
    _topTextfield.delegate= self;
    [self.view addSubview:_topTextfield];
    
    
    _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(25 * W_Wide_Zoom, 68 * W_Hight_Zoom, 100 * W_Wide_Zoom, 35 * W_Hight_Zoom)];
    _placeholderLabel.textColor = [UIColor grayColor];
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    _placeholderLabel.text = @"请输入反馈内容";
    _placeholderLabel.font = _topTextfield.font;
    _placeholderLabel.layer.cornerRadius = 5;
    [self.view addSubview:_placeholderLabel];
    
    UILabel * kuangLabel = [[UILabel alloc]initWithFrame:CGRectMake(30 * W_Wide_Zoom, 205 * W_Hight_Zoom, 315 * W_Wide_Zoom, 35 * W_Hight_Zoom)];
    kuangLabel.layer.cornerRadius = 5;
    kuangLabel.backgroundColor = [UIColor whiteColor];
    kuangLabel.layer.borderWidth = 1;
    kuangLabel.layer.borderColor = LIGHT_GRAY_COLOR.CGColor;
    [self.view addSubview:kuangLabel];
    
    _downTextfield = [[UITextField alloc]initWithFrame:CGRectMake(35 * W_Wide_Zoom, 205 * W_Hight_Zoom, 315 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _downTextfield.placeholder = @"QQ,邮箱或者电话";
    _downTextfield.font = [UIFont systemFontOfSize:13];
    _downTextfield.textColor = [UIColor blackColor];
    _downTextfield.tintColor = GREEN_COLOR;
    [self.view addSubview:_downTextfield];
    
    UILabel * tixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * W_Wide_Zoom, 240 * W_Hight_Zoom, 315 * W_Wide_Zoom, 60 * W_Hight_Zoom)];
    tixingLabel.text = @"您的联系方式有助于我们沟通和解决问题，仅工作人员可见!";
    tixingLabel.numberOfLines = 2;
    tixingLabel.textColor = [UIColor blackColor];
    tixingLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:tixingLabel];

    
}


-(void)textViewDidBeginEditing:(UITextView *)textView{
    _placeholderLabel.text = @"";
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (_topTextfield.text.length == 0) {
        _placeholderLabel.text = @"请输入反馈内容";
    }else{
        _placeholderLabel.text = @"";
    }
    
    
}


-(void)doRightButtonTouch{
    if ([AppUtil isBlankString:_topTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入反馈内容"];
        return;
    }
    if ([AppUtil isBlankString:_downTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入联系方式"];
        return;
    }
    
    [self showHudInView:self.view hint:@"正在发送..."];
    
    
    [[AFHttpClient sharedAFHttpClient] POST:@"sebot/moblie/forward" parameters:@{@"userid" :  [AccountManager sharedAccountManager].loginModel.userid , @"objective":@"user", @"token" : @"1" , @"action" : @"feedback", @"data" : @{@"userid" :  [AccountManager sharedAccountManager].loginModel.userid,@"fcontent":_topTextfield.text,@"type":@"iphone",@"fphone":_downTextfield.text}} result:^(id model) {
        
        [self showSuccessHudWithHint:@"反馈成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
    }];

    
    
}

@end
