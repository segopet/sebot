//
//  CompileViewController.m
//  sebot
//
//  Created by yulei on 16/7/21.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "CompileViewController.h"
#import "NewAlumbleTableViewCell.h"


static NSString * cellId = @"showComCell";
@interface CompileViewController ()

@property (nonatomic,strong)NSMutableArray * adviceArray;
@property (nonatomic,strong)UITextField * alumbnameTextfield;
@end


@implementation CompileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"compilephoto", nil)];
    [self showBarButton:NAV_RIGHT title:@"完成" fontColor:[UIColor whiteColor]];
    self.dataSource =[NSMutableArray array];
    _adviceArray =[NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];


    
}

-(void)doRightButtonTouch{
    
    // 完成上传修改
    
    NSMutableString *deleStr = [[NSMutableString alloc]init];
    NSString *str = [NSString stringWithFormat:@"%@",_adviceArray[0]];
    [deleStr appendFormat:@"%@",str];
    deleStr =[NSMutableString stringWithFormat:@"'%@'",deleStr];
    
    for (int i=1; i<_adviceArray.count; i++) {
        NSString *str = [NSString stringWithFormat:@"%@",_adviceArray[i]];
        [deleStr appendFormat:@",'%@'",str];
        
    }
    NSString * str1 = [AccountManager sharedAccountManager].loginModel.userid;
    
    [[AFHttpClient sharedAFHttpClient]compliePhoto:str1 token:str1 albumname:_alumbnameTextfield.text dids:deleStr aid:self.aidName complete:^(ResponseModel *model) {
        NSLog(@"%@",model.retDesc);
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
    }];
    
    
  
    
}


- (void)onDeleBt:(UIButton *)sender
{
    
     NSString * str1 = [AccountManager sharedAccountManager].loginModel.userid;
    // 删除
    [[AFHttpClient sharedAFHttpClient]delePhoto:str1 token:str1 aid:self.aidName complete:^(ResponseModel *model) {
        
        NSLog(@"%@",model.retDesc);
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    
    
}



-(void)setupData{
    [super setupData];
    [[AFHttpClient sharedAFHttpClient]testWithuserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid complete:^(ResponseModel *model) {
        [self.dataSource addObjectsFromArray:model.list];
        
        [self.tableView reloadData];
    }];
    
    
    
    
}


- (void)setupView
{
    [super setupView];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 * W_Wide_Zoom, 76 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    nameLabel.text = @"相册名称:";
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:nameLabel];
    
    _alumbnameTextfield = [[UITextField alloc]initWithFrame:CGRectMake(95 * W_Wide_Zoom, 76 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _alumbnameTextfield.tintColor = GRAY_COLOR;
    _alumbnameTextfield.text = self.photoName;
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
    
    UIImageView *   _deleteImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, MainScreen.height-40, MainScreen.width, 45)];
    _deleteImageV.userInteractionEnabled = YES;
    _deleteImageV.hidden = NO;
    _deleteImageV.backgroundColor =RED_COLOR;
    _deleteImageV.layer.borderWidth =1;
    _deleteImageV.layer.cornerRadius = 4;
    _deleteImageV.layer.borderColor =GRAY_COLOR.CGColor;
    
    [self.view addSubview:_deleteImageV];
    
    UIButton *   _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.userInteractionEnabled = YES;
    _deleteBtn.frame = CGRectMake(_deleteImageV.center.x-15, 5, 30, 30);
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:GREEN_COLOR forState:UIControlStateNormal];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_deleteBtn addTarget:self action:@selector(onDeleBt:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteImageV addSubview:_deleteBtn];
    
    
    
    self.tableView.frame = CGRectMake(0, 180 * W_Hight_Zoom, self.view.width, self.view.height- 180);
    [self.tableView registerClass:[NewAlumbleTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = nil;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    
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
    
   
    NewAlbumAdviceModel * model = self.dataSource[indexPath.row];
    
    NewAlumbleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell.nameLabel.text = model.deviceremark;
    cell.rightBtn.tag = indexPath.row + 12;
    cell.rightBtn.selected = NO;
    [cell.rightBtn addTarget:self action:@selector(doRightButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}



-(void)doRightButtonTouch:(UIButton *)sender{
    NSInteger i = sender.tag - 12;
    NewAlbumAdviceModel * model = self.dataSource[i];
    
    if (sender.selected == YES) {
        sender.selected = NO;
        [_adviceArray removeObject:model.did];
        
    }else{
        sender.selected = YES;
        [_adviceArray addObject:model.did];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
