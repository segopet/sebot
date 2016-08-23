//
//  CompileViewController.m
//  sebot
//
//  Created by yulei on 16/7/21.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "CompileViewController.h"
#import "NewAlumbleTableViewCell.h"
#import "AFHttpClient+MyPhoto.h"
#import "MyphotoAlbumViewController.h"


#define kMaxLength 4
static NSString * cellId = @"showComCell";
@interface CompileViewController ()<UIActionSheetDelegate,UITextFieldDelegate>

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
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    
       



    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:_alumbnameTextfield];
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if (textField.text.length>=5) {
//        
//        [self showSuccessHudWithHint:@"不能超过4个字符"];
//    }
//    return YES;
//}


-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }  
    }  
}


-(void)doRightButtonTouch{
    
    // 完成上传修改
    if([AppUtil isBlankString:_alumbnameTextfield.text])
    {
        [[AppUtil appTopViewController] showHint:@"相册名称不能为空"];
        
    }else
    {
    NSMutableString *deleStr = [[NSMutableString alloc]init];
    if (_adviceArray.count == 0) {
        
     //   [self.navigationController popViewControllerAnimated:YES];
         [[AppUtil appTopViewController] showHint:@"至少选择一个设备"];
        
    }else{
    NSString *str = [NSString stringWithFormat:@"%@",_adviceArray[0]];
    [deleStr appendFormat:@"%@",str];
    deleStr =[NSMutableString stringWithFormat:@"%@",deleStr];
    
    for (int i=1; i<_adviceArray.count; i++) {
        NSString *str = [NSString stringWithFormat:@"%@",_adviceArray[i]];
        [deleStr appendFormat:@",%@",str];
        
    }

    NSString * str1 = [AccountManager sharedAccountManager].loginModel.userid;
    
    [[AFHttpClient sharedAFHttpClient]compliePhoto:str1 token:str1 albumname:_alumbnameTextfield.text dids:deleStr aid:self.aidName complete:^(ResponseModel *model) {
        NSLog(@"%@",model.retDesc);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"titile" object:_alumbnameTextfield.text];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }];
    
    
    }
  
    }
    
}





- (void)onDeleBt:(UIButton *)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确认删除相册吗?"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"确认", nil];
    [sheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//保存图片
      
        NSArray * ctrlArray = self.navigationController.viewControllers;
        for (UIViewController *ctrl in ctrlArray) {
            
            NSLog(@"ctrl ---- %@", ctrl);
            
        }
        NSString * str1 = [AccountManager sharedAccountManager].loginModel.userid;
        NSMutableString *deleStr = [[NSMutableString alloc]init];
        NSString *str = [NSString stringWithFormat:@"%@",self.aidName];
        [deleStr appendFormat:@"'%@'",str];
        // 删除
        [[AFHttpClient sharedAFHttpClient]delePhoto:str1 token:str1 aid:deleStr complete:^(ResponseModel *model) {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            NewAlumbleTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
             

             [[AppUtil appTopViewController] showHint:model.retDesc];
             [self.navigationController popToViewController:[ctrlArray objectAtIndex:1] animated:YES];
            
        }];
        
    }
    
}


-(void)setupData{
    [super setupData];
    
    NSString * str = [AccountManager sharedAccountManager].loginModel.userid;
    [[AFHttpClient  sharedAFHttpClient]albumdetail:str token:str aid:self.aidName complete:^(ResponseModel *model) {
        
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
    _alumbnameTextfield.delegate = self;
    _alumbnameTextfield.font = [UIFont systemFontOfSize:15];
    _alumbnameTextfield.textColor = [UIColor blackColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:_alumbnameTextfield];
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
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_deleteBtn addTarget:self action:@selector(onDeleBt:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteImageV addSubview:_deleteBtn];
    
    
    
    self.tableView.frame = CGRectMake(0, 170 * W_Hight_Zoom, self.view.width, self.view.height);
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[NewAlumbleTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = GRAY_COLOR;
    self.tableView.tableHeaderView = nil;
    self.tableView.showsVerticalScrollIndicator = NO;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
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
    
    [cell.rightBtn addTarget:self action:@selector(doRightButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([model.chose isEqualToString:@"0"]) {
        cell.rightBtn.selected = NO;
    }else
    {
        cell.rightBtn.selected = YES;
        [_adviceArray addObject:model.did];
        
    }
    
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
