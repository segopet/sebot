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
#import "AFHttpClient+Test.h"


static NSString * cellId = @"newAllubmtabeleviewwcellid";
@interface NewInformationViewController ()<UITextFieldDelegate>
{
    BOOL  ischange;
    BOOL  firstBtn;
}
@property (nonatomic,strong)UITextField * alumbnameTextfield;
@property (nonatomic,strong)NSMutableArray * adviceArray;

@end

@implementation NewInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"新建相册"];
    [UINavigationBar appearance].barTintColor=RED_COLOR;
    _adviceArray = [NSMutableArray array];
    [self showBarButton:NAV_RIGHT title:@"新建" fontColor:[UIColor whiteColor]];
    self.view.backgroundColor = [UIColor whiteColor];

    self.automaticallyAdjustsScrollViewInsets = NO;
}
//新建按钮
-(void)doRightButtonTouch{

    if ([AppUtil isBlankString:_alumbnameTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入相册名称"];
        return;
    }
    if (_adviceArray.count == 0) {
        [[AppUtil appTopViewController] showHint:@"请选择至少一个设备"];
        return;
    }
  
    
    
    NSString * str = [_adviceArray componentsJoinedByString:@","];
    [[AFHttpClient sharedAFHttpClient]POST:@"sebot/moblie/forward" parameters:@{@"userid":[AccountManager sharedAccountManager].loginModel.userid,@"token":[AccountManager sharedAccountManager].loginModel.userid,@"objective":@"album",@"action":@"add",@"data":@{@"albumname":_alumbnameTextfield.text,@"userid":[AccountManager sharedAccountManager].loginModel.userid,@"dids":str}} result:^(id model) {
        
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

-(void)setupView{
    [super  setupView];
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 * W_Wide_Zoom, 76 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    nameLabel.text = @"相册名称:";
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:nameLabel];
    
    _alumbnameTextfield = [[UITextField alloc]initWithFrame:CGRectMake(95 * W_Wide_Zoom, 76 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _alumbnameTextfield.tintColor = GRAY_COLOR;
    _alumbnameTextfield.delegate = self;
    _alumbnameTextfield.placeholder = @"请输入相册名称";
    _alumbnameTextfield.font = [UIFont systemFontOfSize:15];
    _alumbnameTextfield.textColor = [UIColor blackColor];
    [self.view addSubview:_alumbnameTextfield];
    [_alumbnameTextfield addTarget:self action:@selector(textFieldDidChange:)  forControlEvents:UIControlEventEditingChanged];
    
    
    UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 116 * W_Hight_Zoom, 375 * W_Wide_Zoom,1 * W_Hight_Zoom )];
    lineLabel.backgroundColor = GRAY_COLOR;
    [self.view addSubview:lineLabel];
    
    UILabel * zhidingLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 * W_Wide_Zoom, 131 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    zhidingLabel.text = @"指定可见设备";
    zhidingLabel.textColor = [UIColor blackColor];
    zhidingLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:zhidingLabel];    
    
    self.tableView.frame = CGRectMake(0, 175 * W_Hight_Zoom, self.view.width, self.view.height- 175);
    [self.tableView registerClass:[NewAlumbleTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = LIGHT_GRAY_COLOR;
    self.tableView.tableHeaderView = nil;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
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
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if (textField == _alumbnameTextfield) {
//        if (textField.text.length > 10) {
//            [[AppUtil appTopViewController] showHint:@"您最多只能输入10个字"];
//            return NO;
//        }
//    }
//
//    return YES;
//}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == _alumbnameTextfield) {
        if (textField.text.length > 10) {
            textField.text = [textField.text substringToIndex:10];
        }
    }
}


@end