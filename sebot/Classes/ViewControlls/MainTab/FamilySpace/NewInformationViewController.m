//
//  NewInformationViewController.m
//  sebot
//
//  Created by czx on 16/6/23.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "NewInformationViewController.h"
#import "NewAlumbleTableViewCell.h"
#import "NewAlbumAdviceModel.h"

static NSString * cellId = @"newAllubmtabeleviewwcellid";
@interface NewInformationViewController ()
{
    BOOL  ischange;
    BOOL  firstBtn;
}
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
    self.automaticallyAdjustsScrollViewInsets = NO;
}
//新建按钮
-(void)doRightButtonTouch{
    [[AFHttpClient sharedAFHttpClient]POST:@"" parameters:@{} result:^(id model) {
        
    }];

}
-(void)setupData{
    [[AFHttpClient sharedAFHttpClient]POST:@"sebot/moblie/forward" parameters:@{@"userid":[AccountManager sharedAccountManager].loginModel.userid,@"token":[AccountManager sharedAccountManager].loginModel.userid,@"objective":@"album",@"action":@"mydevices",@"data":@{@"userid":[AccountManager sharedAccountManager].loginModel.userid}} result:^(id model) {
        self.dataSource = model[@"list"];

        [self.tableView reloadData];
    }];



}


-(void)setupView{
    [super  setupView];
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
    
    self.tableView.frame = CGRectMake(0, 180 * W_Hight_Zoom, self.view.width, self.view.height- 180);
    [self.tableView registerClass:[NewAlumbleTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = nil;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
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
    return self.dataSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*W_Hight_Zoom;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewAlumbleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
   // NewalumbModel * model = [[NewalumbModel alloc]init];
   // model.isChange = NO;
//    if (ischange == YES) {
//        cell.rightBtn.selected = YES;
//    }else{
//        cell.rightBtn.selected = NO;
//    }
//    if (firstBtn == YES) {
//        if (indexPath.row == 0) {
//            cell.rightBtn.selected = NO;
//        }
//    }
    
    
    cell.rightBtn.tag = indexPath.row + 12;
    [cell.rightBtn addTarget:self action:@selector(doRightButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)doRightButtonTouch:(UIButton *)sender{
    NSInteger i = sender.tag - 12;
    if (i == 0) {
//        NewalumbModel * model = [[NewalumbModel alloc]init];
//       
//        model.isChange = !model.isChange;
       // ischange = !ischange;
        [self.tableView reloadData];
    }else{
       // sender.selected = !sender.selected;
      //  firstBtn = YES;
        [self.tableView reloadData];
        sender.selected = !sender.selected;
    }
    
}






@end
