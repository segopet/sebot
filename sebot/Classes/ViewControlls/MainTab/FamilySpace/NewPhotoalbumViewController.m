//
//  NewPhotoalbumViewController.m
//  sebot
//
//  Created by czx on 16/6/22.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "NewPhotoalbumViewController.h"

@interface NewPhotoalbumViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation NewPhotoalbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"选择相册"];
    [UINavigationBar appearance].barTintColor=RED_COLOR;
    self.view.backgroundColor = NEW_GRAY_COLOR;
    [self initUserface];
}
-(void)initUserface{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *colView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [colView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    colView.backgroundColor = [UIColor whiteColor];
    colView.delegate = self;
    colView.dataSource = self;
    [self.view addSubview:colView];
}

//配置UICollectionView的每个section的item数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
//配置section数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//呈现数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"myCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
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





@end
