//
//  NewInformationViewController.m
//  sebot
//
//  Created by czx on 16/6/23.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "NewInformationViewController.h"
#import "NewAlumbleTableViewCell.h"
static NSString * cellId = @"newAllubmtabeleviewwcellid";
@interface NewInformationViewController ()
@property (nonatomic,strong)UITextField * alumbnameTextfield;
@end

@implementation NewInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"新建相册"];
    [UINavigationBar appearance].barTintColor=RED_COLOR;
    [self showBarButton:NAV_RIGHT title:@"新建" fontColor:[UIColor whiteColor]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUserface];
}

-(void)setupView{
    [super  setupView];
    self.tableView.frame = CGRectMake(0, 125 * W_Hight_Zoom, self.view.width, self.view.height- 100);
    [self.tableView registerClass:[NewAlumbleTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 * W_Wide_Zoom, 76 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    nameLabel.text = @"相册名称:";
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:nameLabel];
    
    _alumbnameTextfield = [[UITextField alloc]initWithFrame:CGRectMake(95 * W_Wide_Zoom, 76 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _alumbnameTextfield.tintColor = GRAY_COLOR;
    _alumbnameTextfield.placeholder = @"请输入相册名称";
    _alumbnameTextfield.font = [UIFont systemFontOfSize:15];
    _alumbnameTextfield.textColor = [UIColor blackColor];
    [self.view addSubview:_alumbnameTextfield];
    
    
    UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 116 * W_Hight_Zoom, 375 * W_Wide_Zoom,1 * W_Hight_Zoom )];
    lineLabel.backgroundColor = GRAY_COLOR;
    [self.view addSubview:lineLabel];
    
    UILabel * zhidingLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 * W_Wide_Zoom, 131 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    zhidingLabel.text = @"指定可见设备";
    zhidingLabel.textColor = [UIColor blackColor];
    zhidingLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:zhidingLabel];
}



-(void)initUserface{
    

}




#pragma mark - TableView的代理函数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*W_Hight_Zoom;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewAlumbleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    
    return cell;
}







@end
