//
//  DeviceInformationViewController.m
//  sebot
//
//  Created by yulei on 16/6/16.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "DeviceInformationViewController.h"
#import "FamilyTeamViewController.h"
#import "InCallViewController.h"
#import "CheckDeviceModel.h"


@interface DeviceInformationViewController ()
{
    
     UIImageView * _heandBtn;
    CheckDeviceModel * checkmodel;
    
}

@end

@implementation DeviceInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    // sip登陆。
    
    [SephoneManager addProxyConfig:[AccountManager sharedAccountManager].loginModel.sipno password:[AccountManager sharedAccountManager].loginModel.sippw domain:@"www.segosip001.cn"];
    

    [self setNavTitle: NSLocalizedString(@"tabDevice", nil)];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    self.dataSource =[NSMutableArray array];
    self.dicSource =[NSMutableArray array];
    
   
    NSArray * arrName =@[NSLocalizedString(@"deviceNumber", nil),NSLocalizedString(@"repairName", nil),NSLocalizedString(@"familyTeam", nil)];
    [self.dicSource addObjectsFromArray:arrName];

   
        
    
   
    // 查询设备信息
        NSString * str1 =[AccountManager sharedAccountManager].loginModel.userid;
        [[AFHttpClient sharedAFHttpClient]deciveInforamtion:str1 token:str1 did:self.didNumber complete:^(ResponseModel * model) {
            
          checkmodel =[[CheckDeviceModel alloc]initWithDictionary:model.retVal error:nil];
            
        
            NSString * str = model.retVal[@"status"];

            // 设备状态 UIbutton
            if ([str isEqualToString:@"ds001"]) {
                
                _heandBtn.image =[UIImage imageNamed:@"on_line"];
                _startBtn.enabled = YES;
                _startBtn.backgroundColor =RED_COLOR;
                
            }else if ([str isEqualToString:@"ds002"])
                
            {
                _heandBtn.image =[UIImage imageNamed:@"off_line"];
                _startBtn.enabled = YES;
                
                
                
            }else
            {
                _heandBtn.image =[UIImage imageNamed:@"on_connection"];
                
                _startBtn.enabled = YES;
                
            }
            [self.tableView reloadData];
            
        }];
        
        
        
      
        
        
        
  

    
}

/**
 *  通知  内存 处理
 *
 *  @param animated diss
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super  viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callUpdate:) name:kSephoneCallUpdate object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registrationUpdate:) name:kSephoneRegistrationUpdate object:nil];
    

}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
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
            NSLog(@"======注销成功")
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



- (void)setupView
{
    
    [super setupView];
    
    
    
    
    
}


- (void)setupData
{
    
    [super setupData];
    UIView  * _headView = [[UIView alloc]initWithFrame:CGRectMake(0* W_Wide_Zoom, 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 260 * W_Hight_Zoom)];
    _headView.backgroundColor =GRAY_COLOR;
    [self.view addSubview:_headView];
    
    // 头像
    _heandBtn =[[UIImageView alloc]initWithFrame:CGRectMake(0, 80, 375, 150)];
    [_headView addSubview:_heandBtn];

    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 430);
    self.tableView.scrollEnabled = NO;
    
    self.tableView.tableHeaderView =_headView;
    self.tableView.showsVerticalScrollIndicator   = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    

}

/**
 *  查询设备状态
 */

- (void)checkDeviceState
{
    
    
    
}






/**
 *  开始视频
 */

- (IBAction)startVideoBtn:(UIButton *)sender {


   [self sipCall:checkmodel.deviceno sipName:nil];
    
    
}


/**
 * 添加设备使用记录
 */

- (void)addDeviceUseMember

{
    
   // "object": "主叫对象(mobile 移动客户端/device 设备端)"
    
    [[AFHttpClient sharedAFHttpClient]POST:@"sebot/moblie/forward" parameters:@{@"userid" : [AccountManager sharedAccountManager].loginModel.userid , @"objective":@"device", @"token" : @"1",@"action":@"addCallRecords",@"data":@{@"calling":@"1001",@"called":@"ds002",@"object":@""}} result:^(id model) {
        
        NSLog(@"%@",model);
        
    }];
    
}

/**
 *  解绑
 */

- (IBAction)cancelDeviceBtn:(UIButton *)sender {
    
    
    [[AFHttpClient sharedAFHttpClient]POST:@"sebot/moblie/forward" parameters:@{@"userid" : [AccountManager sharedAccountManager].loginModel.userid , @"objective":@"device", @"token" : @"1",@"action":@"unbundling",@"data":@{@"userid":[AccountManager sharedAccountManager].loginModel.userid,@"did":@"ds002"}} result:^(id model) {
         NSLog(@"%@",model);
    }];

    

    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma Marr ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count+3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55*W_Hight_Zoom;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * showUserInfoCellIdentifier = @"PerInformation";
    PerInformationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PerInformationTableViewCell" owner:self options:nil]lastObject];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.introduceLable.text = self.dicSource[indexPath.row];
    
    if (indexPath.row ==1 || indexPath.row ==2) {
        //显示箭头
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    if (indexPath.row  ==0) {
        cell.inforLable.text =checkmodel.deviceno;
        
    }else if (indexPath.row ==1)
    {
        
       // cell.introduceLable.text = checkModel.
    }
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CheckDeviceModel *checkModel = [CheckDeviceModel modelWithDictionary:(NSDictionary *)self.dataSource];
    
    if (indexPath.row ==1) {
        // 修改备注
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"repairName", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Sure", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //获取第1个输入框；
            UITextField *userNameTextField = alertController.textFields.firstObject;
            
            // 确认之后这里会获取到 然后更正数组里的备注 要上传服务器
            NSLog(@"备注名 = %@",userNameTextField.text);
            
            [[AFHttpClient sharedAFHttpClient]POST:@"sebot/moblie/forward" parameters:@{@"userid" : [AccountManager sharedAccountManager].loginModel.userid , @"objective":@"device", @"token" : @"1",@"action":@"modifyDeviceRemark",@"data":@{@"userid":[AccountManager sharedAccountManager].loginModel.userid,@"did":checkModel.did,@"remark":userNameTextField.text}} result:^(id model) {
    
                NSLog(@"======%@",model);
                
                
                
            }];

            
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleDefault handler:nil]];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = NSLocalizedString(@"tabDevice", nil);
           // textField.borderStyle =UITextBorderStyleBezel;
            
        }];
       
        
        [self presentViewController:alertController animated:true completion:nil];
    }
     else if (indexPath.row == 2)
     {
         FamilyTeamViewController * famVC =[[FamilyTeamViewController alloc]initWithNibName:@"FamilyTeamViewController" bundle:nil];
         famVC.deviceNum = checkModel.deviceno;
         famVC.did = checkModel.did;
         [self.navigationController pushViewController:famVC animated:YES];
         
         
         
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

#pragma mark - Event Functions

//  call
//
/*
 @dialerNumber 别人的账号
 @sipName 自己的账号
 @ 视频通话
 */
- (void)sipCall:(NSString*)dialerNumber sipName:(NSString *)sipName
{
    
    NSString *  displayName  =nil;
    [[SephoneManager instance] call:dialerNumber displayName:displayName transfer:FALSE];
    
}

@end
