//
//  NewPhotoalbumViewController.m
//  sebot
//
//  Created by czx on 16/6/22.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "NewPhotoalbumViewController.h"
#import "NewInformationViewController.h"
#import "NewAlbumModel.h"
#import "AFHttpClient+Test.h"
#import "IssueViewController.h"
@interface NewPhotoalbumViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,strong)NSMutableArray * datasouce;
@property (nonatomic,strong) UICollectionView *colView;

@property (nonatomic,strong)UIView * downView;
@property (nonatomic,strong)UIButton * bigBtn;
@property (nonatomic,strong)UIView * downwitheView;

@property(nonatomic,strong)UIImagePickerController * imagePicker;

@property (nonatomic,strong)NSString * aidStr;
@end

@implementation NewPhotoalbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"选择相册"];
    _imagePicker =[[UIImagePickerController alloc]init];
    _imagePicker.delegate= self;
    _datasouce  = [NSMutableArray array];
    [UINavigationBar appearance].barTintColor=RED_COLOR;
    self.view.backgroundColor = NEW_GRAY_COLOR;
    [self initUserface];
    [self request];
}
-(void)request{
    //查询接口
    [[AFHttpClient sharedAFHttpClient]newphotoWithUserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid complete:^(ResponseModel *model) {
        if (model.list.count > 0) {
            NSArray * array = model.list;
            [self.datasouce addObject:array[0]];
            [self.datasouce addObjectsFromArray:model.list];
            [_colView reloadData];
        }else{
            //这里写一个就行了
        }
       
    }];
}

-(void)initUserface{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _colView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [_colView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    _colView.backgroundColor = [UIColor whiteColor];
    _colView.delegate = self;
    _colView.dataSource = self;
    [self.view addSubview:_colView];
    
}

//配置UICollectionView的每个section的item数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

  
    return self.datasouce.count;
    
}
//配置section数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//呈现数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    NewAlbumModel * model = self.datasouce[indexPath.row];
    static NSString *cellID = @"myCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    if (indexPath.row < 1) {
        UIImageView * image = [[UIImageView alloc]initWithFrame:cell.bounds];
        image.backgroundColor = [UIColor blueColor];
        [cell addSubview:image];

    }else{
    NSString * imageStr = [NSString stringWithFormat:@"%@",model.cover];
    NSURL * imageUrl = [NSURL URLWithString:imageStr];
    UIImageView * image = [[UIImageView alloc]initWithFrame:cell.bounds];
    [image sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"APPImgae.png"]];
    [cell addSubview:image];
    }
    
    
    
    return cell;
}

//配置每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110, 110);
}

//配置item的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(9, 9, 0, 9);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"您点击了item:%ld",indexPath.row);
    if (indexPath.row < 1) {
        NewInformationViewController * haha = [[NewInformationViewController alloc]init];
        [self.navigationController pushViewController:haha animated:NO];
    }else{
        NewAlbumModel * model = self.datasouce[indexPath.row];
        _aidStr = model.aid;
        
        [self downButttonUp];
        
    }
}

-(void)downButttonUp{
    _bigBtn = [[UIButton alloc]initWithFrame:self.view.frame];
    _bigBtn.backgroundColor = [UIColor lightGrayColor];
    _bigBtn.alpha = 0.6;
    [[UIApplication sharedApplication].keyWindow addSubview:_bigBtn];
    [_bigBtn addTarget:self action:@selector(bigButtonHiddin:) forControlEvents:UIControlEventTouchUpInside];
   //两个按键的view
    _downView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame), 667 * W_Hight_Zoom, 375 * W_Wide_Zoom, 80 * W_Hight_Zoom)];
    //取消按键 
    _downwitheView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 667 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
    
    [UIView animateWithDuration:0.3 animations:^{
        _downView.frame = CGRectMake(0 * W_Wide_Zoom, 535 * W_Hight_Zoom, 375 * W_Wide_Zoom, 80 * W_Hight_Zoom);
        _downView.backgroundColor = [UIColor whiteColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_downView];

        _downwitheView.frame = CGRectMake(0 * W_Wide_Zoom, 627 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom);
        _downwitheView.backgroundColor = [UIColor whiteColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_downwitheView];
     }];
    NSArray * nameAry = @[@"拍照",@"相册"];
    for (int i = 0 ; i < 2; i++) {
   
            UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 40 * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
            lineLabel.backgroundColor = LIGHT_GRAY_COLOR;
            [_downView addSubview:lineLabel];
        
        UIButton * buttones = [[UIButton alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom + i * 40 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
        [buttones setTitle:nameAry[i] forState:UIControlStateNormal];
        [buttones setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        buttones.titleLabel.font = [UIFont systemFontOfSize:14];
        [_downView addSubview:buttones];
        buttones.tag = i + 12;
        [buttones addTarget:self action:@selector(buttonesTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIButton * dancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
    [dancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [dancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    dancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_downwitheView addSubview:dancelBtn];
    [dancelBtn addTarget:self action:@selector(bigButtonHiddin:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)buttonesTouch: (UIButton *)sender{
    if (sender.tag == 12) {
        [self takephoto];
    }else if (sender.tag == 13){
        [self loacalPhoto];
    }
    
}

-(void)takephoto{
    [self bigButtonHiddin:nil];
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

-(void)loacalPhoto{
    [self bigButtonHiddin:nil];
    NSArray * mediaTypers = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _imagePicker.mediaTypes = @[mediaTypers[0],mediaTypers[1]];
        _imagePicker.allowsEditing = YES;
    }
    [self presentViewController:_imagePicker animated:NO completion:nil];

}

//得到图片之后的处理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //NSMutableArray * imageArray = [[NSMutableArray alloc]init];
    UIImage * getImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    //[imageArray addObject:getImage];
    
    [self dismissViewControllerAnimated:NO completion:nil];
//    IssuePinViewController * vC = [[IssuePinViewController alloc]init];
//    vC.firstImage = getImage;
//    [self.navigationController pushViewController:vC animated:YES];
    IssueViewController * issue = [[IssueViewController alloc]init];
    issue.firstImage = getImage;
    issue.aidstr = _aidStr;
    [self presentViewController:issue animated:YES completion:nil];
    
    
}








-(void)bigButtonHiddin:(UIButton *)sender{
    _bigBtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _downView.frame = CGRectMake(0 * W_Wide_Zoom, 667 * W_Hight_Zoom, 375 * W_Wide_Zoom, 80 * W_Hight_Zoom);
        
        _downwitheView.frame = CGRectMake(0 * W_Wide_Zoom, 667 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom);
    }];

}

@end