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
#import "UIImageView+WebCache.h"
#import "PersonModel.h"
#import "UIImage-Extensions.h"
#import "AFHttpClient+Person.h"
#import "AFHttpClient+Alumb.h"


@interface PersonCenterViewcontroller()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

{
    
    UIImageView * _heandBtn;
    NSMutableArray * arrTest;
    NSMutableArray * arrImage;
    UILabel *_nameLabel;
    
    PersonModel *checkModel;
    UITextField *_userNameTextField;
    
    
}
@property(nonatomic,strong)UIImagePickerController * imagePicker;
@end

@implementation PersonCenterViewcontroller



- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"tabPerson", nil)];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    _imagePicker =[[UIImagePickerController alloc]init];
    _imagePicker.delegate= self;
    
    
}


-(void)loadDataSourceWithPage:(int)page{
    
    NSString * str =[AccountManager sharedAccountManager].loginModel.userid;
    
   [[AFHttpClient sharedAFHttpClient]deciveInforamtion:str token:str  complete:^(ResponseModel * model) {
        
        if (page == START_PAGE_INDEX) {
           
            checkModel = [[PersonModel alloc]initWithDictionary:model.retVal error:nil];
            [_heandBtn sd_setImageWithURL:[NSURL URLWithString:checkModel.headportrait] placeholderImage:nil];
            _nameLabel.text = checkModel.nickname;
            
        } else {
            
        }
        
        if (model.list.count < REQUEST_PAGE_SIZE){
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
        
        [self.tableView reloadData];
        [self handleEndRefresh];
        
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
    _nameLabel.center = CGPointMake(_headView.center.x,_headView.center.y+60);
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor blackColor];
    [_headView addSubview:_nameLabel];
    
    // 头像
    _heandBtn =[[UIImageView alloc]initWithFrame:CGRectMake(0,0,130, 130)];
    _heandBtn.center = CGPointMake(_headView.center.x, _headView.center.y-20);
    _heandBtn.layer.masksToBounds = YES;
    _heandBtn.userInteractionEnabled = YES;
    _heandBtn.layer.cornerRadius =_heandBtn.width/2;
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFrom:)];
       [_headView addSubview:_heandBtn];
    [_heandBtn addGestureRecognizer:singleRecognizer];


    
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
    
    [self  initRefreshView];


    
}

- (void)setupData
{
    [super setupData];
    
    self.dataSource =[NSMutableArray array];
    NSArray * arr =@[@"账号",@"昵称",@"我的相册",@"修改密码",@"关于"];
    [self.dataSource addObjectsFromArray:arr];
    arrTest =[NSMutableArray array];
    NSArray * arrT =@[@"13540691705",@"Tony",@"",@"",@""];
    [arrTest addObjectsFromArray:arrT];
    arrImage =[NSMutableArray array];
    NSArray * arrI =@[@"acount",@"test11",@"photo",@"paword",@"about"];
    [arrImage addObjectsFromArray:arrI];

    
}



// 头像点击事件


- (void)handleSingleTapFrom:(UITapGestureRecognizer *)sender
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改头像" message:nil preferredStyle:  UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        
        [self openPhotoPram];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
       
        [self getPhoto];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        
      
        
    }]];

    [self presentViewController:alert animated:true completion:nil];
    
}

/**
 *  相册
 */
- (void)openPhotoPram
{
    NSArray * mediaTypers = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _imagePicker.mediaTypes = @[mediaTypers[0],mediaTypers[1]];
        _imagePicker.allowsEditing = YES;
    }
    [self presentViewController:_imagePicker animated:YES completion:nil];
    
    
}


/**
 *  拍照
 */
- (void)getPhoto
{
    
    NSArray * mediaty = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.mediaTypes = @[mediaty[0]];
        //设置相机模式：1摄像2录像
        _imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        //使用前置还是后置摄像头
        _imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        //闪光模式
        _imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        _imagePicker.allowsEditing = YES;
    }else
    {
        NSLog(@"打开摄像头失败");
    }
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

#pragma Marr ------ UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage * showImage = info[UIImagePickerControllerEditedImage];
    NSLog(@"wocaocao:%@",showImage);
    _heandBtn.image = showImage;
    [self updateHeadImage:showImage];
    [self dismissViewControllerAnimated:YES completion:nil];



}


/**
 * 上传头像
 */

- (void)updateHeadImage:(UIImage *)source
{
    NSDateFormatter * formater =[[NSDateFormatter alloc]init];
    NSData * data = UIImageJPEGRepresentation(source,1.0f);
    
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    [formater stringFromDate:[NSDate date]];
    NSString *picname1 = [NSString stringWithFormat:@"%@.jpg",[formater stringFromDate:[NSDate date]]];
    
    
    NSString * pictureDataString = [data base64EncodedStringWithOptions:0];
    // NSLog(@"%@",pictureDataString);
    
    NSString *  picstr = [NSString stringWithFormat:@"[{\"%@\":\"%@\",\"%@\":\"%@\"}]",@"name",picname1,@"content",pictureDataString];
    
    NSString * str =  [AccountManager sharedAccountManager].loginModel.userid;
    [[AFHttpClient sharedAFHttpClient]updateHead:str token:str image:picstr complete:^(ResponseModel * model) {
        
        NSLog(@"%@",model);
    }];
    
    
    
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
    if (indexPath.row == 0) {
        cell.inforLable.text = checkModel.phone;
        
    }else if (indexPath.row == 1)

    {
        cell.inforLable.text = checkModel.nickname;
        
        
    }else
    {
        
        cell.inforLable.text = @"";
    }
    cell.headImage.image =[UIImage imageNamed:arrImage[indexPath.row]];
   
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row ==1) {
        // 修改备注
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"repairName", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //获取第1个输入框；)
            _userNameTextField = [[UITextField alloc]init];
            _userNameTextField = alertController.textFields.firstObject;
            _userNameTextField.delegate = self;
            [self repairName:_userNameTextField.text];
    
            [_userNameTextField addTarget:self action:@selector(textFieldDidChange1:)  forControlEvents:UIControlEventEditingChanged];
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleDefault handler:nil]];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = NSLocalizedString(@"tabDevice", nil);
        }];
        
        
        [self presentViewController:alertController animated:true completion:nil];
    }
    else if (indexPath.row == 2)
    {
        
      NSMutableArray *  _listArray = [NSMutableArray array];
        [[AFHttpClient sharedAFHttpClient]querMydeviceWithUserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid complete:^(ResponseModel *model) {
            
            [_listArray addObjectsFromArray:model.list];
            if (_listArray.count > 0 ) {
                MyphotoAlbumViewController * Myphot0VC =[[MyphotoAlbumViewController alloc]initWithNibName:@"MyphotoAlbumViewController" bundle:nil];
                [self.navigationController pushViewController:Myphot0VC animated:YES];
                
            }else {
                [[AppUtil appTopViewController] showHint:@"你还没有绑定设备"];            }
        }];

        
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


// 修改备注名

- (void)repairName:(NSString *)textname
{
    
    if (textname.length > 10) {
        [[AppUtil appTopViewController]showHint:@"昵称只能10字以内"];
        textname = [textname substringToIndex:10];
        }
    
    NSString * str= [AccountManager sharedAccountManager].loginModel.userid;
    [[AFHttpClient sharedAFHttpClient]repairname:str token:str nickname:textname complete:^(ResponseModel * model) {
        NSLog(@"修改昵称");
        
        [self initRefreshView];
    }];

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


- (void)textFieldDidChange1:(UITextField *)textField
{
    if (textField == _userNameTextField) {
        if (textField.text.length > 10) {
            textField.text = [textField.text substringToIndex:10];
        }
    }
}


@end
