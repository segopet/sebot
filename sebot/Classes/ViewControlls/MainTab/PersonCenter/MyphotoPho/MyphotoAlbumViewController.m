//
//  MyphotoAlbumViewController.m
//  sebot
//
//  Created by yulei on 16/6/17.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "MyphotoAlbumViewController.h"

@interface MyphotoAlbumViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

{
    
    
    int number;
    
}

@end

@implementation MyphotoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setNavTitle: NSLocalizedString(@"MyphotoAlbum", nil)];
     self.view.backgroundColor = LIGHT_GRAY_COLOR;
    number = 10;
    
    
}


- (void)setupData
{
    
    [super setupData];
    
}

- (void)setupView
{
    
    [super setupView];
    
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为100*100
    layout.itemSize = CGSizeMake(100, 100);
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView * collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    //代理设置
    collect.delegate=self;
    collect.dataSource=self;
    //注册item类型 这里使用系统的类型
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
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
    return number;
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    NSLog(@"选中");
   
}


@end
