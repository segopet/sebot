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
#import "FamilyTeamModel.h"
#import "AFHttpClient+FamilyTeam.h"
#import "AppUtil.h"

@interface FamilyTeamViewController ()<PopDelegate>

{
    
    PopView * _popView;
    AppDelegate *app;
    FamilyTeamModel * famModel;
    NSString * strControl;
    BOOL  isMeControl;
    
    
}

@end

@implementation FamilyTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTitle: NSLocalizedString(@"familyTeam", nil)];
     self.view.backgroundColor = LIGHT_GRAY_COLOR;
    isMeControl = NO;
    
    self.dataSource =[NSMutableArray array];
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _popView = [[PopView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT)];
    
     NSString * str =[AccountManager sharedAccountManager].loginModel.userid;
    
    NSLog(@"%@",str);
    
    [_popView.sureBtn setTitle:@"邀请" forState:UIControlStateNormal];
     _popView.handLable.text = @"邀请绑定";
     _popView.numberLable.text = @"手机号码:";
     _popView.numberTextfied.placeholder = @"输入对方手机号";
    _popView.saomaBtnl.hidden = YES;
    _popView.ParentView = app.window;
    _popView.delegate = self;
    
    NSLog(@"......");
    
    

    
}


- (void)setupData
{
    [super setupData];
    
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


- (void)setupView
{
    [super setupView];
    [self initRefreshView];
    
    
    
}


-(void)loadDataSourceWithPage:(int)page{
    
    NSString * str =[AccountManager sharedAccountManager].loginModel.userid;
    
    // 家庭成员接口
    [[AFHttpClient sharedAFHttpClient]familyteam:str token:str did:self.did complete:^(ResponseModel * model) {
        if (page == START_PAGE_INDEX) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:model.list];
            famModel = self.dataSource[0];
            // 管理员
            strControl  = famModel.userid;
            
        } else {
            [self.dataSource addObjectsFromArray:model.list];
        }
        
        if (model.list.count < REQUEST_PAGE_SIZE){
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
        
        
        [self.tableView reloadData];
        [self handleEndRefresh];
        
    }];
    
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
    
    
    
    if ([AppUtil isValidateMobile:_popView.numberTextfied.text]) {
        
        // 管理员邀请接口
        NSString * str = [AccountManager sharedAccountManager].loginModel.userid;
        [[AFHttpClient sharedAFHttpClient]invate:str token:str admin:str phone: _popView.numberTextfied.text deviceno:self.deviceNum complete:^(ResponseModel *model) {
            [self  showSuccessHudWithHint:@"邀请已发送"];
            [_popView removeFromSuperview];
        }];

    }
    else
    {
        [self showSuccessHudWithHint:@"请输入正确的手机格式"];
        
    }
    

    
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
    
    famModel =self.dataSource[indexPath.row];

    static NSString * showUserInfoCellIdentifier = @"MyFamilyList";
    FamilyTeamTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FamilyTeamTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLable.text = famModel.nickname;
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:famModel.headportrait] placeholderImage:[UIImage imageNamed:@"APPImgae"]];
    cell.headImage.layer.masksToBounds = YES;
    cell.headImage.layer.cornerRadius = cell.headImage.size.width/2;
   
    
   
    cell.moveBtn.tag = 1000+indexPath.row;
    cell.transferBtn.tag = 2000+indexPath.row;
    [cell.moveBtn addTarget:self  action:@selector(moveMetod:) forControlEvents:UIControlEventTouchUpInside];
    [cell.transferBtn addTarget:self action:@selector(transferMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
      if (indexPath.row ==0) {
        
        cell.conterLable.hidden = NO;
        
    }
     if (indexPath.row == 0 && [strControl isEqualToString:[AccountManager sharedAccountManager].loginModel.userid]) {
         cell.moveBtn.hidden = YES;
         cell.transferBtn.hidden = YES;
         cell.conterLable.hidden  = NO;
         isMeControl = YES;
         [self showBarButton:NAV_RIGHT title:NSLocalizedString(@"invitation", nil) fontColor:[UIColor whiteColor]];
         
       }
     else if (indexPath.row>0)
     {
         cell.conterLable.hidden  = YES;
         
         if (isMeControl) {
             cell.moveBtn.hidden = NO;
             cell.transferBtn.hidden = NO;
             
         }else
         {
         cell.moveBtn.hidden = YES;
         cell.transferBtn.hidden = YES;
     
     
         }
     
     }

    
    

    return cell;
    
}


/**
 * 移除
 */

- (void)moveMetod:(UIButton *)sender
{
    
    NSLog(@"======%ld",sender.tag-1000);
    NSInteger num = sender.tag -1000;
    famModel =self.dataSource[num];
   // 管理员移除用户
     NSString * str =[NSString stringWithFormat:@"你确认移除成员［%@］吗？",famModel.nickname];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"成员移除" message:str preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 操作为更改权限
        NSString * str = [AccountManager sharedAccountManager].loginModel.userid;
        [[AFHttpClient sharedAFHttpClient]move:str token:str admin:strControl usr:famModel.userid did:famModel.did complete:^(ResponseModel * model) {
            [self showSuccessHudWithHint:model.retDesc];
            [self initRefreshView];
        }];

        
        
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:true completion:nil];
    
    
    
}

/**
 * 转让
 */


- (void)transferMethod:(UIButton *)sender
{
    NSInteger  num  = sender.tag -2000;
    [self mesaggTitle:nil informationTitle:nil terger:num];
    
    
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

- (void)mesaggTitle:(NSString *)title informationTitle:(NSString *)title1 terger:(NSInteger)sender
{
    famModel =self.dataSource[sender];
    
    NSString * str =[NSString stringWithFormat:@"您确认把管理员转让给［%@］吗?",famModel.nickname];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"管理员转让" message:str preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 操作为更改权限

            // 转让接口
        NSString * str = [AccountManager sharedAccountManager].loginModel.userid;
            [[AFHttpClient sharedAFHttpClient]givePowr:str token:str admin:strControl usr:famModel.userid did:famModel.did complete:^(ResponseModel * model) {
                [self showSuccessHudWithHint:model.retDesc];
                isMeControl = NO;
                [self.navigationController popViewControllerAnimated:YES];
                
               

            }];
        
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:true completion:nil];
    
}



@end
