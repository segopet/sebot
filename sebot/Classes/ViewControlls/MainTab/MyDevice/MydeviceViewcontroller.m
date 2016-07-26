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


@interface MydeviceViewcontroller()<PopDelegate>
{
    
    
    PopView * _popView;
    AppDelegate *app;
   // CheckDeviceModel * checkModel;
    UIImageView * image;
    
    

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
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated

{
    [super viewWillDisappear:animated];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"s_m_text"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"tabDevice", nil)];
    self.view.backgroundColor = GRAY_COLOR;
    [self showBarButton:NAV_RIGHT imageName:@"sebot_add"];
    
    image =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 375)];
    image.hidden = YES;
    image.center = self.view.center;
    image.image =[UIImage imageNamed:@"无图时.png"];
    [self.view addSubview:image];
    
     app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _popView = [[PopView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT)];
    _popView.center = self.view.center;
    _popView.ParentView = app.window;
    _popView.delegate = self;
    self.dataSource =[NSMutableArray array];


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
    self.tableView.backgroundColor =LIGHT_GRAY_COLOR;
    
    self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.tableView.tableHeaderView =[[UIView alloc]initWithFrame:CGRectZero];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }

    
    
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
        
        
    }
    [[AFHttpClient sharedAFHttpClient]addDevide:str token:str deviceno:_popView.numberTextfied.text complete:^(ResponseModel * model) {
        [_popView removeFromSuperview];
        [self showSuccessHudWithHint:model.retDesc];
        
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
        cell.VideoStateBtn.enabled = YES;
        
    }else
    {
        // 灰色  不能开启
        
        [cell.VideoStateBtn setImage:[UIImage imageNamed:@"sebot_start_off"] forState:UIControlStateNormal];
        cell.VideoStateBtn.enabled = NO;
        
        
    }
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CheckDeviceModel *checkModel = self.dataSource[indexPath.row];
    DeviceInformationViewController * inforationVC =[[DeviceInformationViewController alloc]initWithNibName:@"DeviceInformationViewController" bundle:nil];
    inforationVC.didNumber = checkModel.did;

    MyDeviceTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.VideoStateBtn.enabled) {
        [self.navigationController pushViewController:inforationVC animated:YES];
    }else
    {
        
        [self showSuccessHudWithHint:@"该设备暂时无法开启视频"];
        
    }
    

    
    
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




@end
