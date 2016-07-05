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

@interface NewPhotoalbumViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)NSMutableArray * datasouce;
@property (nonatomic,strong) UICollectionView *colView;

@property (nonatomic,strong)UIView * downView;
@property (nonatomic,strong)UIButton * bigBtn;
@property (nonatomic,strong)UIView * downwitheView;

@end

@implementation NewPhotoalbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"选择相册"];
    _datasouce  = [NSMutableArray array];
    [UINavigationBar appearance].barTintColor=RED_COLOR;
    self.view.backgroundColor = NEW_GRAY_COLOR;
    [self initUserface];
    [self request];
}
-(void)request{
    //查询接口
    [[AFHttpClient sharedAFHttpClient]newphotoWithUserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid complete:^(ResponseModel *model) {
        
        NSArray * array = model.list;
        [self.datasouce addObject:array[0]];
        [self.datasouce addObjectsFromArray:model.list];
         [_colView reloadData];
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
        [self takePhoto];
        
    }
}

-(void)takePhoto{
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
        _downView.frame = CGRectMake(0 * W_Wide_Zoom, 527 * W_Hight_Zoom, 375 * W_Wide_Zoom, 80 * W_Hight_Zoom);
        _downView.backgroundColor = [UIColor blueColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_downView];

        _downwitheView.frame = CGRectMake(0 * W_Wide_Zoom, 627 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom);
        _downwitheView.backgroundColor = [UIColor blueColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_downwitheView];
     }];

    
    
    
    
    
    
}

-(void)bigButtonHiddin:(UIButton *)sender{
    sender.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _downView.frame = CGRectMake(0 * W_Wide_Zoom, 667 * W_Hight_Zoom, 375 * W_Wide_Zoom, 80 * W_Hight_Zoom);
        
        _downwitheView.frame = CGRectMake(0 * W_Wide_Zoom, 667 * W_Hight_Zoom, 375 * W_Wide_Zoom, 40 * W_Hight_Zoom);
    }];

}

@end