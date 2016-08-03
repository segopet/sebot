//
//  MydeviceViewcontroller.m
//  sebot
//
//  Created by yulei on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "MydeviceViewcontroller.h"
#import "PopView.h"
#import "MyDeviceTableViewCell.h"
#import "DeviceInformationViewController.h"
#import "SaomaoViewController.h"
#import "CheckDeviceModel.h"
#import "AFHttpClient+MyDevice.h"
#import "AppUtil.h"
#import "InCallViewController.h"
#import "AFHttpClient+DeviceInformation.h"


@interface MydeviceViewcontroller()<PopDelegate>
{
    
    
    PopView * _popView;
    AppDelegate *app;
   // CheckDeviceModel * checkModel;
    UIImageView * image;
    
    NSString * titleStr;
    
    
    

}


@end



@implementation MydeviceViewcontroller




- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 接收下级界面传回来的值
    
    NSUserDefaults * defults =[NSUserDefaults standardUserDefaults];
    NSString * str =[defults objectForKey:@"s_m_text"];
    _popView.numberTextfied.text= str;
     [self initRefreshView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callUpdate:) name:kSephoneCallUpdate object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registrationUpdate:) name:kSephoneRegistrationUpdate object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pass) name:@"haha" object:nil];
    
    

}

- (void)pass

{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated

{
    [super viewWillDisappear:animated];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"s_m_text"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSephoneCallUpdate object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kSephoneRegistrationUpdate object:nil];
    
    
}

// 注册消息处理
- (void)registrationUpdate:(NSNotification *)notif {
    SephoneRegistrationState state = [[notif.userInfo objectForKey:@"state"] intValue];
    SephoneProxyConfig *cfg = [[notif.userInfo objectForKey:@"cfg"] pointerValue];
    // Only report bad credential issue
    
    
    
    
    
    switch (state) {
            
        case SephoneRegistrationNone:
            
            NSLog(@"======开始");
            break;
        case SephoneRegistrationProgress:
            NSLog(@"=====注册进行");
            break;
        case SephoneRegistrationOk:
            
            NSLog(@"=======成功");
            break;
        case SephoneRegistrationCleared:
            break;
        case SephoneRegistrationFailed:
            NSLog(@"========OK 以外都是失败");
            break;
            
        default:
            break;
    }
    
}


// 通话状态处理
- (void)callUpdate:(NSNotification *)notif {
    SephoneCall *call = [[notif.userInfo objectForKey:@"call"] pointerValue];
    SephoneCallState state = [[notif.userInfo objectForKey:@"state"] intValue];
    
    switch (state) {
        case SephoneCallOutgoingInit:{
            // 成功
            InCallViewController *   _incallVC =[[InCallViewController alloc]initWithNibName:@"InCallViewController" bundle:nil];
           _incallVC.titileStr = titleStr;
            [_incallVC setCall:call];
            [self presentViewController:_incallVC animated:YES completion:nil];
            break;
        }
            
        case SephoneCallStreamsRunning: {
            break;
        }
        case SephoneCallUpdatedByRemote: {
            break;
        }
            
        default:
            break;
    }
}




- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"tabDevice", nil)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self showBarButton:NAV_RIGHT imageName:@"sebot_add"];
    
    image =[[UIImageView alloc]initWithFrame:CGRectMake(60 * W_Wide_Zoom, 200 * W_Hight_Zoom, 250 * W_Wide_Zoom, 250 * W_Hight_Zoom)];
    image.hidden = YES;
    //image.center = self.view.center;
    image.image =[UIImage imageNamed:@"无图时.png"];
    [self.view addSubview:image];
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _popView = [[PopView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT)];
    
    _popView.center = self.view.center;
    _popView.ParentView = app.window;
    _popView.delegate = self;
    self.dataSource =[NSMutableArray array];
    
    
    [SephoneManager addProxyConfig:[AccountManager sharedAccountManager].loginModel.sipno password:[AccountManager sharedAccountManager].loginModel.sippw domain:@"www.segosip001.cn"];

    
    
}

/**
 *  继承
 */
- (void)setupView
{
    
    [super setupView];
    
    
}


// 刷新

-(void)loadDataSourceWithPage:(int)page{
    
    NSString * str =[AccountManager sharedAccountManager].loginModel.userid;
    
    [[AFHttpClient sharedAFHttpClient]checkmoel:str token:str complete:^(ResponseModel * model) {
        
        if (page == START_PAGE_INDEX) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:model.list];
            image.hidden = YES;
        } else {
            [self.dataSource addObjectsFromArray:model.list];
            image.hidden  =  YES;
        }
        
        if (model.list.count < REQUEST_PAGE_SIZE){
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
        
        if (self.dataSource.count ==0) {
            
            NSLog(@"没有设备");
            
            image.hidden = NO;
            //[self showNoticView];
            
        }
        [self.tableView reloadData];
        [self handleEndRefresh];
        
    }];
    
}


//提示框

- (void)showNoticView
{
    UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:nil message:@"你还有绑定设备,是否立即绑定" delegate:self cancelButtonTitle:@"稍后" otherButtonTitles:@"立即绑定", nil];
    [alertView show];
    
    

    
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;{

    if (buttonIndex == 0) {
        
        
    }else
    {
         [self.view addSubview:_popView];
        
    }
    
}



- (void)setupData

{
    
    [super setupData];
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
   // self.tableView.scrollEnabled = NO;
    
    
    self.tableView.showsVerticalScrollIndicator   = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor =[UIColor whiteColor];
    self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.tableView.tableHeaderView =[[UIView alloc]initWithFrame:CGRectZero];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }

    
    self.tableView.scrollEnabled =NO;
    
    
}

- (void)doRightButtonTouch
{
    
    [self.view addSubview:_popView];

}




/**
 *  pop 代理
 */

- (void)saomaMehod
{
    
    NSLog(@"11");
    SaomaoViewController * saomoVC =[[SaomaoViewController alloc]initWithNibName:@"SaomaoViewController" bundle:nil];
    [self.navigationController pushViewController:saomoVC animated:YES];
    
    
}
- (void)cancelMehod
{
    
    NSLog(@"22");
    
    [_popView removeFromSuperview];
}
/**
 *  绑定
 */
- (void)sureMehod
{
    
    NSString * str = [AccountManager sharedAccountManager].loginModel.userid;
    
    if ([AppUtil isBlankString:_popView.numberTextfied.text]) {
         _popView.numberTextfied.text= [[NSUserDefaults standardUserDefaults]objectForKey:@"s_m_text"];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDAnimationFade;//枚举类型不同的效果
        hud.labelText=@"加载中.......";
        [_popView removeFromSuperview];
        
    }
    [[AFHttpClient sharedAFHttpClient]addDevide:str token:str deviceno:_popView.numberTextfied.text complete:^(ResponseModel * model) {
        [[AppUtil appTopViewController] showHint:model.retDesc];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
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
   
    
    CheckDeviceModel *checkModel = self.dataSource[indexPath.row];
    
    static NSString * showUserInfoCellIdentifier = @"MydeviceList";
    MyDeviceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyDeviceTableViewCell" owner:self options:nil]lastObject];
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     cell.numberLable.text =checkModel.deviceremark;
    // 设备不存在：ds000,在线：ds001,离线：ds002,通话中：ds003
    
    if ([checkModel.status  isEqualToString:@"ds001"]) {
        // 可以去开启视频
        
        [cell.VideoStateBtn setImage:[UIImage imageNamed:@"sebot_start_on"] forState:UIControlStateNormal];
        cell.VideoStateBtn.tag = 1000+indexPath.row;
        [cell.VideoStateBtn addTarget:self action:@selector(showWaitViewSu:) forControlEvents:UIControlEventTouchUpInside];
        cell.VideoStateBtn.enabled = YES;
    }else
    {
        // 灰色  不能开启
        
        [cell.VideoStateBtn setImage:[UIImage imageNamed:@"sebot_start_off"] forState:UIControlStateNormal];
        [cell.VideoStateBtn addTarget:self action:@selector(showWaitView) forControlEvents:UIControlEventTouchUpInside];
        cell.VideoStateBtn.enabled = YES;
        
    }
    
    
    
    return cell;
    
}

- (void)showWaitView
{
    [self showYuLei:@"设备暂不能开启"];
}


- (void)showWaitViewSu:(UIButton *)sender
{
    NSLog(@"成功是直接开启");
    NSInteger i  = sender.tag -1000;
    
    CheckDeviceModel *checkModel = self.dataSource[i];
    
    titleStr = checkModel.deviceremark;
    [self sipCall:checkModel.deviceno sipName:nil];
    [self addDeviceUseMember:checkModel.did];
}


/**
 * 添加设备使用记录
 */

- (void)addDeviceUseMember:(NSString *)str1

{
    
    // "object": "主叫对象(mobile 移动客户端/device 设备端)"
    
    NSString  * str = [AccountManager sharedAccountManager].loginModel.userid;
    
    [[AFHttpClient sharedAFHttpClient]solvDevice:str token:str call:str called:str1 object:@"mobile" complete:^(ResponseModel *model) {
        
        NSUserDefaults * user =[NSUserDefaults standardUserDefaults];
        [user setObject:model.content forKey:@"contentID"];
        [user synchronize];
        
        
    }];
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CheckDeviceModel *checkModel = self.dataSource[indexPath.row];
    DeviceInformationViewController * inforationVC =[[DeviceInformationViewController alloc]initWithNibName:@"DeviceInformationViewController" bundle:nil];
    inforationVC.didNumber = checkModel.did;

  //  MyDeviceTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
  //  if (cell.VideoStateBtn.enabled) {
        [self.navigationController pushViewController:inforationVC animated:YES];
    
    

    
    
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


- (void)sipCall:(NSString*)dialerNumber sipName:(NSString *)sipName
{
    
    NSString *  displayName  =nil;
    [[SephoneManager instance]call:dialerNumber displayName:displayName transfer:FALSE highDefinition:FALSE];
    
    
}


@end
