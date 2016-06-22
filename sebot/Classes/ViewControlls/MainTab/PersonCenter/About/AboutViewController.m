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
    NSArray * arr =@[@"产品简介",@"意见反馈",@"注册协议"];
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
    _headView.backgroundColor =GRAY_COLOR;
    [self.view addSubview:_headView];
    
    /**
     点赞  名字
     */
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200*W_Wide_Zoom, 20*W_Hight_Zoom)];
    _nameLabel.text = @"V1.0";
    _nameLabel.center = CGPointMake(_headView.center.x,_heandBtn.frame.origin.y+130*W_Hight_Zoom);
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor redColor];
    [_headView addSubview:_nameLabel];
    
    // 头像
    _heandBtn =[[UIImageView alloc]initWithFrame:CGRectMake(_headView.center.x-40*W_Wide_Zoom, self.view.origin.y+30*W_Hight_Zoom, 80, 80)];
    _heandBtn.image =[UIImage imageNamed:@"launguide.jpg"];
    _heandBtn.layer.masksToBounds = YES;
    _heandBtn.layer.cornerRadius =_heandBtn.width/2;
    [_headView addSubview:_heandBtn];
    
    
    self.tableView.frame = CGRectMake(0, 60, SCREEN_WIDTH, 500);
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
    
    

    cell.nameLable.text =self.dataSource[indexPath.row];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if (indexPath.row == 0) {
        
        ProductionIntroducViewController * proVC =[[ProductionIntroducViewController alloc]initWithNibName:@"ProductionIntroducViewController" bundle:nil];
        [self.navigationController  pushViewController:proVC animated:YES];
        
        
    }
    else if (indexPath.row  ==1)
    {
        
        OpinionViewController * opinVC =[[OpinionViewController alloc]initWithNibName:@"OpinionViewController" bundle:nil];
        [self.navigationController pushViewController:opinVC animated:YES];
        
    }
    else
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
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@NO];
    [[AccountManager sharedAccountManager]logout];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end