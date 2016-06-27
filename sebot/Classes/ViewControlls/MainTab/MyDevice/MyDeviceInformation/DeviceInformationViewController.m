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
    
}

@end

@implementation DeviceInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setNavTitle: NSLocalizedString(@"tabDevice", nil)];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    self.dataSource =[NSMutableArray array];
    self.dicSource =[NSMutableArray array];
    
   
    NSArray * arrName =@[NSLocalizedString(@"tabDevice", nil),NSLocalizedString(@"deviceNumber", nil),NSLocalizedString(@"familyTeam", nil)];
    [self.dicSource addObjectsFromArray:arrName];

    // 查询设备信息
    [[AFHttpClient sharedAFHttpClient]POST:@"sebot/moblie/forward" parameters:@{@"userid" : @"1" , @"objective":@"device", @"token" : @"1",@"action":@"queryByIdDeviceInfo",@"data":@{@"userid":@"1",@"did":self.didNumber}} result:^(id model) {
        
        self.dataSource =model[@"retVal"];
    
        NSString * str = model[@"retVal"][@"status"];
        
        
        // 设备状态 UIbutton
        if ([str isEqualToString:@"ds001"]) {
            
            _heandBtn.image =[UIImage imageNamed:@"on_line"];
            _startBtn.enabled = YES;
            _startBtn.backgroundColor =RED_COLOR;
            
        }else if ([str isEqualToString:@"ds002"])
       
        {
            _heandBtn.image =[UIImage imageNamed:@"off_line"];
            _startBtn.enabled = NO;

            
            
        }else
        {
            _heandBtn.image =[UIImage imageNamed:@"on_connection"];
            
            _startBtn.enabled = NO;
            
        }
        [self.tableView reloadData];
        
        
        
    }];


    
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
    
    InCallViewController * InCallVC =[[InCallViewController alloc
                                       ]initWithNibName:@"InCallViewController" bundle:nil];

    [self presentViewController:InCallVC animated:YES completion:nil];
}


/**
 * 添加设备使用记录
 */

- (void)addDeviceUseMember

{
    
   // "object": "主叫对象(mobile 移动客户端/device 设备端)"
    
    [[AFHttpClient sharedAFHttpClient]POST:@"sebot/moblie/forward" parameters:@{@"userid" : @"1" , @"objective":@"device", @"token" : @"1",@"action":@"addCallRecords",@"data":@{@"calling":@"1001",@"called":@"ds002",@"object":@""}} result:^(id model) {
        
        NSLog(@"%@",model);
        
    }];
    
}

/**
 *  解绑
 */

- (IBAction)cancelDeviceBtn:(UIButton *)sender {
    
    
    [[AFHttpClient sharedAFHttpClient]POST:@"sebot/moblie/forward" parameters:@{@"userid" : @"1" , @"objective":@"device", @"token" : @"1",@"action":@"unbundling",@"data":@{@"userid":@"1001",@"did":@"ds002"}} result:^(id model) {
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
    return self.dataSource.count-10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55*W_Hight_Zoom;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     CheckDeviceModel *checkModel = [CheckDeviceModel modelWithDictionary:(NSDictionary *)self.dataSource];
    
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
        cell.inforLable.text =checkModel.deviceno;
        
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
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //获取第1个输入框；
            UITextField *userNameTextField = alertController.textFields.firstObject;
            // 确认之后这里会获取到 然后更正数组里的备注 要上传服务器
            NSLog(@"备注名 = %@",userNameTextField.text);
            
            [[AFHttpClient sharedAFHttpClient]POST:@"sebot/moblie/forward" parameters:@{@"userid" : @"1" , @"objective":@"device", @"token" : @"1",@"action":@"modifyDeviceRemark",@"data":@{@"userid":@"1",@"did":checkModel.did,@"remark":userNameTextField.text}} result:^(id model) {
    
                NSLog(@"======%@",model);
                
                
                
            }];

            
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleDefault handler:nil]];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = NSLocalizedString(@"tabDevice", nil);
        }];
       
        
        [self presentViewController:alertController animated:true completion:nil];
    }
     else if (indexPath.row == 2)
     {
         FamilyTeamViewController * famVC =[[FamilyTeamViewController alloc]initWithNibName:@"FamilyTeamViewController" bundle:nil];
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


@end
