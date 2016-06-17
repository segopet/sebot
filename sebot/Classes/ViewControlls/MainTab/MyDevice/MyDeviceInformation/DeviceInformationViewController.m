//
//  DeviceInformationViewController.m
//  sebot
//
//  Created by yulei on 16/6/16.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "DeviceInformationViewController.h"

@interface DeviceInformationViewController ()
{
    
     UIImageView * _heandBtn;
    NSMutableArray * introduceArr;
    
}

@end

@implementation DeviceInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setNavTitle: NSLocalizedString(@"tabDevice", nil)];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    self.dataSource =[NSMutableArray array];
    introduceArr =[NSMutableArray array];
    NSArray * arrName1 =@[@"9001",@"我的设备",@""];
    NSArray * arrName =@[NSLocalizedString(@"tabDevice", nil),NSLocalizedString(@"deviceNumber", nil),NSLocalizedString(@"familyTeam", nil)];
    [self.dataSource addObjectsFromArray:arrName];
    [introduceArr addObjectsFromArray:arrName1];

    
}


- (void)setupView
{
    
    [super setupView];
    
    UIView  * _headView = [[UIView alloc]initWithFrame:CGRectMake(0* W_Wide_Zoom, 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 260 * W_Hight_Zoom)];
    _headView.backgroundColor =GRAY_COLOR;
    
    [self.view addSubview:_headView];
    
    // 头像
    _heandBtn =[[UIImageView alloc]initWithFrame:CGRectMake(_headView.center.x-40*W_Wide_Zoom, self.view.origin.y+30*W_Hight_Zoom, 80, 80)];
   // _heandBtn.image =[UIImage imageNamed:@""];
    
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
    
    
}

/**
 *  解绑
 */

- (IBAction)cancelDeviceBtn:(UIButton *)sender {
    
    
}



- (void)setupData
{
    [super setupData];
    
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
    return self.dataSource.count;
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

    cell.introduceLable.text = self.dataSource[indexPath.row];
    
    if (indexPath.row ==1 || indexPath.row ==2) {
        //显示箭头
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    cell.inforLable.text = introduceArr[indexPath.row];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row ==1) {
        // 修改备注
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"repairName", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //获取第1个输入框；
            UITextField *userNameTextField = alertController.textFields.firstObject;
            
            // 确认之后这里会获取到 然后更正数组里的备注 要上传服务器
            NSLog(@"备注名 = %@",userNameTextField.text);
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleDefault handler:nil]];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = NSLocalizedString(@"tabDevice", nil);
        }];
       
        
        [self presentViewController:alertController animated:true completion:nil];
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
