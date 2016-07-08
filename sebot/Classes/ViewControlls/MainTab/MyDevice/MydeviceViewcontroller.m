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


@interface MydeviceViewcontroller()<PopDelegate>
{
    
    
    PopView * _popView;
    AppDelegate *app;
   // CheckDeviceModel * checkModel;
    

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
    
    
    
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"tabDevice", nil)];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    [self showBarButton:NAV_RIGHT imageName:@"sebot_add"];
    
     app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _popView = [[PopView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT)];
    _popView.center = self.view.center;
    _popView.ParentView = app.window;
    _popView.delegate = self;
   
    
    self.dataSource =[NSMutableArray array];
   

    
    NSString * str =[AccountManager sharedAccountManager].loginModel.userid;
    
    [[AFHttpClient sharedAFHttpClient]checkmoel:str token:str complete:^(ResponseModel * model) {
      
        [self.dataSource addObjectsFromArray:model.list];
        [self.tableView reloadData];
        
    } ];
    
    


}

/**
 *  继承
 */
- (void)setupView
{
    
    [super setupView];
    
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
    _popView.numberTextfied.text= [[NSUserDefaults standardUserDefaults]objectForKey:@"s_m_text"];
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
     cell.numberLable.text =checkModel.deviceno;
    // 设备不存在：ds000,在线：ds001,离线：ds002,通话中：ds003
    
    if ([checkModel.status  isEqualToString:@"ds001"]) {
        // 可以去开启视频
        
        [cell.VideoStateBtn setImage:[UIImage imageNamed:@"sebot_start_on"] forState:UIControlStateNormal];
        
    }else
    {
        // 灰色  不能开启
        
        [cell.VideoStateBtn setImage:[UIImage imageNamed:@"sebot_start_off"] forState:UIControlStateNormal];
        
    }
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CheckDeviceModel *checkModel = self.dataSource[indexPath.row];
    DeviceInformationViewController * inforationVC =[[DeviceInformationViewController alloc]initWithNibName:@"DeviceInformationViewController" bundle:nil];
    inforationVC.didNumber = checkModel.did;
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




@end
