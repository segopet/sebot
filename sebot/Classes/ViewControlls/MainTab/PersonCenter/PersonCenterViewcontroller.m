//
//  PersonCenterViewcontroller.m
//  sebot
//
//  Created by yulei on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "PersonCenterViewcontroller.h"
#import "MyphotoAlbumViewController.h"
#import "AboutViewController.h"
#import "RepairPwViewController.h"
@interface PersonCenterViewcontroller()

{
    
    UIImageView * _heandBtn;
    NSMutableArray * arrTest;
    NSMutableArray * arrImage;
    UILabel *_nameLabel;
    
    
    
}

@end

@implementation PersonCenterViewcontroller



- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"tabPerson", nil)];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    self.dataSource =[NSMutableArray array];
    NSArray * arr =@[@"账号",@"昵称",@"我的相册",@"修改密码",@"关于"];
    [self.dataSource addObjectsFromArray:arr];
    arrTest =[NSMutableArray array];
    NSArray * arrT =@[@"13540691705",@"Tony",@"",@"",@""];
    [arrTest addObjectsFromArray:arrT];
    arrImage =[NSMutableArray array];
    NSArray * arrI =@[@"acount",@"test11",@"photo",@"paword",@"about"];
    [arrImage addObjectsFromArray:arrI];
    
    
   NSString * str =  [AccountManager sharedAccountManager].loginModel.userid;
    
    
    [[AFHttpClient sharedAFHttpClient] POST:@"sebot/moblie/forward" parameters:@{@"userid" : str , @"objective":@"user", @"token" : @"1" , @"action" : @"queryUser", @"data" : @{@"userid" : str}} result:^(id model) {
        
        //[self.dataSource addObjectsFromArray:model[@"list"]];
        
        [self.tableView reloadData];
    }];

    
}


- (void)setupView
{
    [super setupView];
    
    UIView  * _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, 220 * W_Hight_Zoom)];
    _headView.backgroundColor =LIGHT_GRAY_COLOR;
    [self.view addSubview:_headView];
    
    /**
     点赞  名字
     */
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    _nameLabel.text = @"我是余磊";
    _nameLabel.center = CGPointMake(_headView.center.x,_headView.center.y+60);
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor redColor];
    [_headView addSubview:_nameLabel];
    
    // 头像
    _heandBtn =[[UIImageView alloc]initWithFrame:CGRectMake(0,0,130, 130)];
    _heandBtn.center = CGPointMake(_headView.center.x, _headView.center.y-20);
     _heandBtn.image =[UIImage imageNamed:@"APPImgae.png"];
    _heandBtn.layer.masksToBounds = YES;
    _heandBtn.layer.cornerRadius =_heandBtn.width/2;
    [_headView addSubview:_heandBtn];

    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
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

- (void)setupData
{
    [super setupData];
    
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
    
    static NSString * showUserInfoCellIdentifier = @"Personcell";
    PersonTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PersonTableViewCell" owner:self options:nil]lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row ==0) {
        //显示箭头
        
        
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    cell.introduceLable.text = self.dataSource[indexPath.row];
    cell.inforLable.text = arrTest[indexPath.row];
    cell.headImage.image =[UIImage imageNamed:arrImage[indexPath.row]];
   
    
    
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
    else if (indexPath.row == 2)
    {
        
        MyphotoAlbumViewController * Myphot0VC =[[MyphotoAlbumViewController alloc]initWithNibName:@"MyphotoAlbumViewController" bundle:nil];
        [self.navigationController pushViewController:Myphot0VC animated:YES];
        
    }
    else if (indexPath.row == 3)
    {
        
        RepairPwViewController  * repaVC =[[RepairPwViewController alloc]initWithNibName:@"RepairPwViewController" bundle:nil];
        
        [self.navigationController pushViewController:repaVC animated:YES];
        
    }
    
    else if (indexPath.row == 4)
        
    {
        
        AboutViewController * aboutVC =[[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
        [self.navigationController pushViewController:aboutVC animated:YES];
        
        
        
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
