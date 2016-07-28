//
//  MyphotoAlbumViewController.m
//  sebot
//
//  Created by yulei on 16/6/17.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "MyphotoAlbumViewController.h"
#import "NewInformationViewController.h"
#import "PhotoInformationViewController.h"
#import "PhotoCollectionViewCell.h"
#import "AFHttpClient+MyPhoto.h"


@interface MyphotoAlbumViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

{
    
    
    NSMutableArray * arrData;
    NSString * usid;
    UICollectionView * collect;
    UIImageView * DefaultesImage;
    
    
    
    
}

@end

@implementation MyphotoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    usid = [AccountManager sharedAccountManager].loginModel.userid;
    [self setNavTitle: NSLocalizedString(@"MyphotoAlbum", nil)];
    self.view.backgroundColor = [UIColor whiteColor];
    DefaultesImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 60*W_Hight_Zoom, 110*W_Wide_Zoom, 110*W_Hight_Zoom)];
    DefaultesImage.image =[UIImage imageNamed:@"add.png"];
    DefaultesImage.hidden = YES;
    DefaultesImage.userInteractionEnabled = YES;
    [self.view addSubview:DefaultesImage];
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFromT:)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [DefaultesImage addGestureRecognizer:singleRecognizer];
    
    arrData = [NSMutableArray array];
    
}


- (void)handleSingleTapFromT:(UITapGestureRecognizer *)recognizer {
    
    NewInformationViewController * haha = [[NewInformationViewController alloc]init];
    [self.navigationController pushViewController:haha animated:YES];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self request];
    
}

-(void)request{
    //查询接口

    
    [[AFHttpClient sharedAFHttpClient]QueryMyPhoto:usid token:usid complete:^(ResponseModel * model) {
        
        if (model.list.count > 0) {
            DefaultesImage.hidden = YES;
                        NSArray * array = model.list;
                        [arrData removeAllObjects];
                        [arrData addObject:array[0]];
                        [arrData addObjectsFromArray:model.list];
                        [collect reloadData];
                    }else{
                        //这里写一个就行了
                        
                        NSLog(@"222");
                        DefaultesImage.hidden = NO;
                        
                        
                    }

        
    }];
    
    
}



- (void)setupData
{
    
    [super setupData];
    
}

- (void)setupView
{
    
    [super setupView];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    //代理设置
    collect.backgroundColor =[UIColor whiteColor];
    collect.delegate=self;
    collect.dataSource=self;
    //注册item类型 这里使用系统的类型X
    [collect registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.view addSubview:collect];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



#pragma mark -- UICollectionViewDelegate


//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arrData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110 * W_Wide_Zoom, 110 * W_Hight_Zoom);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(13,11, 0, 11);
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NewAlbumModel * model = arrData[indexPath.row];
    
    PhotoCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    if (indexPath.row < 1) {
        cell.ImageHeader.image =[UIImage imageNamed:@"add.png"];
        cell.PhotoNumber.hidden = YES;
        cell.PhotoName.hidden = YES;
        cell.downImageV.hidden = YES;
        
        
        
        
    }else{
        cell.PhotoNumber.hidden = NO;
        cell.PhotoName.hidden = NO;
        cell.downImageV.hidden = NO;
       
        NSString * imageStr = [NSString stringWithFormat:@"%@",model.cover];
        NSURL * imageUrl = [NSURL URLWithString:imageStr];

        [cell.ImageHeader sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"defaultPhoto.png"]];
        cell.PhotoName.text = model.albumname;
        cell.PhotoNumber.text = model.photonum;
        
        
        
        
    }
    
    return cell;

}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    NSLog(@"选中");
     NewAlbumModel * model = arrData[indexPath.row];
    if (indexPath.row < 1) {
        NewInformationViewController * haha = [[NewInformationViewController alloc]init];
        [self.navigationController pushViewController:haha animated:NO];
    }else{
       //相册预览
       
        PhotoInformationViewController * photoVC =[[PhotoInformationViewController alloc]initWithNibName:@"PhotoInformationViewController" bundle:nil];
        photoVC.aid = model.aid;
        photoVC.albumname = model.albumname;
        [self.navigationController pushViewController:photoVC animated:YES];
        
    }

   
}



@end
