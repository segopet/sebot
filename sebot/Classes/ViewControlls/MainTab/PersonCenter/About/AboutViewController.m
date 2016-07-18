//
//  AboutViewController.m
//  sebot
//
//  Created by yulei on 16/6/17.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutTableViewCell.h"
#import "AgreementViewController.h"
#import "OpinionViewController.h"
#import "ProductionIntroducViewController.h"

@interface AboutViewController ()
{
    
    UIImageView *_heandBtn;
    UILabel *  _nameLabel;
    
    
}

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTitle: NSLocalizedString(@"About", nil)];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    
    self.dataSource =[NSMutableArray array];
    NSArray * arr =@[@"意见反馈",@"注册协议"];
    [self.dataSource addObjectsFromArray:arr];
    
}

- (void)setupData
{
    [super setupData];
    
}



- (void)setupView
{
    [super setupView];
    
    UIView  * _headView = [[UIView alloc]initWithFrame:CGRectMake(0* W_Wide_Zoom, 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 220 * W_Hight_Zoom)];
    _headView.backgroundColor =LIGHT_GRAY_COLOR;
    [self.view addSubview:_headView];
    
    /**
     点赞  名字
     */
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    _nameLabel.text = @"V1.0";
    _nameLabel.center = CGPointMake(_headView.center.x,_heandBtn.frame.origin.y+200);
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor redColor];
    [_headView addSubview:_nameLabel];
    
    // 头像
    _heandBtn =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 130)];
    _heandBtn.center =_headView.center;
    _heandBtn.image =[UIImage imageNamed:@"APPImgae"];
    _heandBtn.layer.masksToBounds = YES;
    _heandBtn.layer.cornerRadius =_heandBtn.width/2;
    [_headView addSubview:_heandBtn];
    
    
    self.tableView.frame = CGRectMake(0, 60, SCREEN_WIDTH, 330);
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
    
    static NSString * showUserInfoCellIdentifier = @"Aboutcell";
    AboutTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AboutTableViewCell" owner:self options:nil]lastObject];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLable.text =self.dataSource[indexPath.row];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if (indexPath.row == 0) {
        
        OpinionViewController * opinVC =[[OpinionViewController alloc]initWithNibName:@"OpinionViewController" bundle:nil];
        [self.navigationController pushViewController:opinVC animated:YES];
    }
    else if (indexPath.row  ==1)
    {
        AgreementViewController * aggreVC =[[AgreementViewController alloc]initWithNibName:@"AgreementViewController" bundle:nil];
        [self.navigationController pushViewController:aggreVC animated:YES];
        
        
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

/**
 *  退出
 */
- (IBAction)exitBtn:(UIButton *)sender {
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@NO];
//    [[AccountManager sharedAccountManager]logout];
//    
    
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@NO];
        [[AccountManager sharedAccountManager]logout];
        // 清除plist
        NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
        NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
        for(NSString* key in [dictionary allKeys]){
            [userDefatluts removeObjectForKey:key];
            [userDefatluts synchronize];
        }
        [userDefatluts setObject:@"1" forKey:@"STARTFLAG"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
