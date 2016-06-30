//
//  FamilyTeamViewController.m
//  sebot
//
//  Created by yulei on 16/6/17.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "FamilyTeamViewController.h"
#import "FamilyTeamTableViewCell.h"
#import "PopView.h"

@interface FamilyTeamViewController ()<PopDelegate>

{
    
    PopView * _popView;
    AppDelegate *app;
}

@end

@implementation FamilyTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTitle: NSLocalizedString(@"familyTeam", nil)];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    [self showBarButton:NAV_RIGHT title:NSLocalizedString(@"invitation", nil) fontColor:[UIColor redColor]];
    
    self.dataSource =[NSMutableArray array];
    NSArray * arrName =@[@"Tony",@"Mer",@"Tina"];
    [self.dataSource addObjectsFromArray:arrName];
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _popView = [[PopView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT)];
    [_popView.sureBtn setTitle:@"邀请" forState:UIControlStateNormal];
     _popView.handLable.text = @"邀请绑定";
     _popView.numberLable.text = @"手机号码:";
     _popView.numberTextfied.placeholder = @"输入对方手机号";
    _popView.saomaBtnl.hidden = YES;
    _popView.ParentView = app.window;
    _popView.delegate = self;
    
    // 家庭成员接口
    [[AFHttpClient sharedAFHttpClient]POST:@"sebot/moblie/forward" parameters:@{@"userid" : [AccountManager sharedAccountManager].loginModel.userid , @"objective":@"device", @"token" : @"1",@"action":@"queryFamilyMember",@"data":@{@"did":@""}} result:^(id model) {
        
        NSLog(@"%@",model[@"retDesc"]);
       
    }];

    
    
}


- (void)setupData
{
    [super setupData];
    
}


- (void)setupView
{
    [super setupView];
    
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    // self.tableView.scrollEnabled = NO;
    
    
    self.tableView.showsVerticalScrollIndicator   = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.tableView.tableHeaderView =[[UIView alloc]initWithFrame:CGRectZero];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }

    
}

/**
 *  邀请
 */
- (void)doRightButtonTouch
{
    // 提示框
    [self.view addSubview:_popView];
    
    
}


#pragma mark -- popdelegate

- (void)cancelMehod
{
    
    NSLog(@"22");
    [_popView removeFromSuperview];
}
- (void)sureMehod
{
    NSLog(@"33");
    
    // 管理员邀请接口
    [[AFHttpClient sharedAFHttpClient]POST:@"sebot/moblie/forward" parameters:@{@"userid" : [AccountManager sharedAccountManager].loginModel.userid , @"objective":@"device", @"token" : @"1",@"action":@"inviteRequest",@"data":@{@"userid":[AccountManager sharedAccountManager].loginModel.userid,@"phone":@"9000000006",@"deviceno":@""}} result:^(id model) {
        
        NSLog(@"%@",model[@"retDesc"]);
        [_popView removeFromSuperview];
        
    }];

    
}



#pragma Marr ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55*W_Hight_Zoom;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * showUserInfoCellIdentifier = @"MyFamilyList";
    FamilyTeamTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FamilyTeamTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLable.text = self.dataSource[indexPath.row];
    cell.moveBtn.tag = 1000+indexPath.row;
    cell.transferBtn.tag = 2000+indexPath.row;
    [cell.moveBtn addTarget:self  action:@selector(moveMetod:) forControlEvents:UIControlEventTouchUpInside];
    [cell.transferBtn addTarget:self action:@selector(transferMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    if (indexPath.row == 0) {
        
    }else
    {
        cell.moveBtn.hidden = NO;
        cell.transferBtn.hidden = NO;
        cell.conterLable.hidden  = YES;
    }
    
    return cell;
    
}


/**
 * 移除
 */

- (void)moveMetod:(UIButton *)sender
{
    
    NSLog(@"======%ld",sender.tag-1000);
    
   // 管理员移除用户
    [[AFHttpClient sharedAFHttpClient]POST:@"sebot/moblie/forward" parameters:@{@"userid" : [AccountManager sharedAccountManager].loginModel.userid , @"objective":@"device", @"token" : @"1",@"action":@"remove",@"data":@{@"admin":@"1",@"usrid":@"9000000006",@"did":@""}} result:^(id model) {
        
        NSLog(@"%@",model[@"retDesc"]);
       
    }];
    
    
    
}

/**
 * 转让
 */


- (void)transferMethod:(UIButton *)sender
{
    
    // 转让接口
    [[AFHttpClient sharedAFHttpClient]POST:@"sebot/moblie/forward" parameters:@{@"userid" : [AccountManager sharedAccountManager].loginModel.userid , @"objective":@"device", @"token" : @"1",@"action":@"transfer",@"data":@{@"admin":@"1",@"usrid":@"9000000006",@"did":@""}} result:^(id model) {
        
        NSLog(@"%@",model[@"retDesc"]);
        
    }];

    
    
    
    
    // 提示框 操作
     NSLog(@"======%ld",sender.tag-2000);
    [self mesaggTitle:nil informationTitle:nil];
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    
}




- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *
 *  @param title 提示头
 *  @param title 提示副本
 */

- (void)mesaggTitle:(NSString *)title informationTitle:(NSString *)title1
{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"管理员转让" message:@"你确定将管理员权限转让给余磊吗" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 操作为更改权限
        NSLog(@"223232");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleDefault handler:nil]];
    

    
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

@end
