//
//  PhotoInformationViewController.m
//  sebot
//
//  Created by yulei on 16/7/20.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "PhotoInformationViewController.h"
#import "AFHttpClient+MyPhoto.h"
#import "PhotoInforamtion.h"
#import "PhotoModel.h"
#import "ShowPhotoViewController.h"
#import "ImageModel.h"
#import "CompileViewController.h"


static NSString *kfooterIdentifier = @"footerIdentifier";
static NSString *kheaderIdentifier = @"headerIdentifier";


@interface PhotoInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    NSMutableArray * arrData;
    NSMutableArray * arrAid;
    NSString * strusid;
    BOOL isSlect;
    NSMutableArray * deledArr;
    UIImageView * _deleteImageV;
    UIButton * _deleteBtn;
    
    UITableView * tabTop;
    NSArray * rightArr;
    NSString * albumnameStr;
    NSString * aidName;
    
    
    
    
    
    
}

@end

@implementation PhotoInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle: self.albumname];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    [self showBarButton:NAV_RIGHT imageName:@"more"];
    arrData =[NSMutableArray array];
    deledArr =[NSMutableArray array];
    arrAid =[NSMutableArray array];
    strusid= [AccountManager sharedAccountManager].loginModel.userid;
    isSlect = NO;
    [self initRefreshView];
    
}



- (void)datapageNum:(int)page
{
    
   
    
    
    [[AFHttpClient sharedAFHttpClient]QueryMyPhotos:strusid token:strusid did:self.aid page:[NSString stringWithFormat:@"%d",page] complete:^(ResponseModel *model) {
        NSLog(@"%@",model);
        
        // model.list.count > 0 &&
        if (page==START_PAGE_INDEX) {
            [arrData removeAllObjects];
            [arrData addObjectsFromArray:model.list];
           
        }else{
            //这里写一个就行了
            
            if (model.list.count == 0) {
                [self showSuccessHudWithHint:@"没有更多数据哦"];
            }else
            {
                  [arrData addObjectsFromArray:model.list];
            }
    
        }
        
        [self.collection reloadData];
        [self handleEndRefresh];
        
    }];
    
}

- (void)doRightButtonTouch
{
    
    tabTop.hidden = NO;
    
    
    // 管理相册
    
}

- (void)setupData
{
    
    [super setupData];
  NSString  * strusid1= [AccountManager sharedAccountManager].loginModel.userid;
    
    [[AFHttpClient sharedAFHttpClient]QueryMyPhoto:strusid1 token:strusid1 complete:^(ResponseModel * model) {
        
        NSLog(@"%@",model);
        [arrAid addObjectsFromArray:model.list];
       
    }];
    
    
}


- (void)setupView
{
    [super setupView];
    
    self.collection.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.collection.showsHorizontalScrollIndicator = NO;
    self.collection.showsVerticalScrollIndicator   = NO;
    [self.collection registerClass:[PhotoInforamtion class] forCellWithReuseIdentifier:@"imageId"];
    [self.collection registerNib:[UINib nibWithNibName:@"SQSupplementaryView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfooterIdentifier];
    [self.collection registerNib:[UINib nibWithNibName:@"HeaderViewCollection" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    self.collection.backgroundColor = [UIColor whiteColor];
    
    
    _deleteImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, MainScreen.height-40, MainScreen.width, 45)];
    _deleteImageV.userInteractionEnabled = YES;
    _deleteImageV.hidden = YES;
    _deleteImageV.backgroundColor =RED_COLOR;
    _deleteImageV.layer.borderWidth =1;
    _deleteImageV.layer.cornerRadius = 4;
    _deleteImageV.layer.borderColor =GRAY_COLOR.CGColor;
    
    [self.view addSubview:_deleteImageV];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.frame = CGRectMake(_deleteImageV.center.x-15, 5, 30, 30);
    //    [_deleteBtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_deleteBtn addTarget:self action:@selector(onDeleBt:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteImageV addSubview:_deleteBtn];
    
   
    rightArr =@[@"管理相册",@"编辑相册"];
    tabTop =[[UITableView alloc]initWithFrame:CGRectMake(280 * W_Wide_Zoom, 60 * W_Hight_Zoom, 100 * W_Wide_Zoom, 100 * W_Hight_Zoom) style:UITableViewStylePlain];
    tabTop.layer.borderWidth = 1;
    tabTop.layer.borderColor =GRAY_COLOR.CGColor;
    tabTop.hidden = YES;
    tabTop.backgroundColor =[UIColor redColor];
    tabTop.delegate = self;
    tabTop.dataSource = self;
    tabTop.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    tabTop.tableHeaderView =[[UIView alloc]initWithFrame:CGRectZero];
    
    if ([tabTop respondsToSelector:@selector(setSeparatorInset:)]) {
        [tabTop setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([tabTop respondsToSelector:@selector(setLayoutMargins:)]) {
        [tabTop setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        
    }
    
    [self.view addSubview:tabTop];

    
    
    
}




#pragma Marr ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return rightArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55*W_Hight_Zoom;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString * showUserInfoCellIdentifier = @"rightcell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (!cell) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:showUserInfoCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text =rightArr[indexPath.row];
    
    return cell;
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (indexPath.row ==0) {
        tabTop.hidden = YES;
        isSlect = YES;
        _deleteImageV.hidden= NO;
        // 编辑相册
        for (int i=0; i<arrData.count; i++) {
            PhotoModel *model = arrData[i];
            NSArray *imageA = [model.networkaddress componentsSeparatedByString:@","];
            for (int j=0; j<imageA.count; j++) {
                PhotoInforamtion *cell = (PhotoInforamtion *)[self.collection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
                cell.chooseBtn.hidden = NO;
                cell.chooseBtn.selected = NO;
            }
        }

        
    }else
    {
        // 管理相册
        
        
        CompileViewController * comVC = [[CompileViewController alloc]initWithNibName:@"CompileViewController" bundle:nil];
        comVC.photoName =albumnameStr;
        comVC.aidName = self.aid;
        
        [self.navigationController pushViewController:comVC animated:YES];
        
        
        
        
    }
    
    
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



/**
 *  删除
 */

-(void)onDeleBt:(UIButton *)sender
{
    
    if (deledArr.count>0) {//有所需要删除的数据
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"你确定要删除所选图片!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }else{
        [self showSuccessHudWithHint:@"请选择要删除的照片"];
    }
    
    
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        /*
        for (int i=0; i<arrData.count; i++) {
            PhotoModel *model = arrData[i];
            NSArray *imageA = [model.photoname componentsSeparatedByString:@","];
            
            
            for (int j=0; j<imageA.count; j++) {
                PhotoInforamtion *cell = (PhotoInforamtion *)[self.collection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            
            }
            
        }
         */
        
        _deleteImageV.hidden = YES;
        NSMutableString *deleStr = [[NSMutableString alloc]init];
        NSString *str = [NSString stringWithFormat:@"%@",deledArr[0]];
        [deleStr appendFormat:@"%@",str];
        deleStr =[NSMutableString stringWithFormat:@"'%@'",deleStr];
        
        for (int i=1; i<deledArr.count; i++) {
            NSString *str = [NSString stringWithFormat:@"%@",deledArr[i]];
            [deleStr appendFormat:@",'%@'",str];
            
        }
    
        [[AFHttpClient sharedAFHttpClient]Deletephoto:strusid token:strusid  pids:deleStr complete:^(ResponseModel * model) {
            
            [self showSuccessHudWithHint:model.retCode];
            [self initRefreshView];
            
        }];
        
        
    }
}




#pragma mark -- UICollectionViewDelegate


//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return arrData.count;
    
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    PhotoModel *model;
    if (arrData.count>0) {
        model = arrData[section];
    }
    NSArray *imageA = [model.networkaddress componentsSeparatedByString:@","];
    return imageA.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110, 110);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 0, 5);
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoModel * model;
     model = arrData[indexPath.section];
     NSArray *imageA = [model.networkaddress componentsSeparatedByString:@","];
    albumnameStr = model.albumname;
    aidName = model.aid;
    
     PhotoInforamtion *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageId" forIndexPath:indexPath];
     NSString *urlstr = @"";
    if(![AppUtil isBlankString:imageA[indexPath.row]]){
        urlstr = imageA[indexPath.row];
    }
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageNamed:@"defaultPhoto.png"]];
    cell.chooseBtn.selected = NO;
    cell.headImage.backgroundColor = [UIColor blackColor];
    cell.headImage.tag = 1000*(indexPath.section+1) +indexPath.row;
    cell.headImage.userInteractionEnabled = YES;

    UITapGestureRecognizer *tapMYP = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onImageVVV:)];
    [cell.headImage addGestureRecognizer:tapMYP];
    
    
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    NSLog(@"选中");
    
    
    
}



//头部
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {350,20};
    return size;
}



//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size={350,20};
    return size;
}


// heder和footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        reuseIdentifier = kfooterIdentifier;
        
    }else{
        reuseIdentifier = kheaderIdentifier;
    }
    
    UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        UILabel *label = (UILabel *)[view viewWithTag:2222];
        view.backgroundColor =[UIColor whiteColor];
        
        PhotoModel *model;
        if (arrData.count>0) {
            model = arrData[indexPath.section];
        }
        
        NSArray *timeTtile =[model.createtime componentsSeparatedByString:@","];
        label.text =timeTtile[indexPath.row];
        
        
        
        
        
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UILabel *label = (UILabel *)[view viewWithTag:1111];
        view.backgroundColor =[UIColor whiteColor];
        label.backgroundColor =GRAY_COLOR;
        
        
    }
    return view;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    /*
     NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
     UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
     //获取当前选中cell
     NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
     
     */
}




// 每张图的点击
- (void)onImageVVV:(UITapGestureRecognizer *)imageSender
{
    
    if (isSlect) {
        NSInteger i = imageSender.view.tag/1000;//分区
        int j = imageSender.view.tag%1000;//每个分区的分组
        PhotoModel *model = arrData[i-1];
        NSArray *imageA = [model.pid componentsSeparatedByString:@","];
        PhotoInforamtion *cell = (PhotoInforamtion *)[self.collection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i-1]];
        
        if (cell.chooseBtn.hidden == NO && cell.chooseBtn.selected==NO) {
            cell.chooseBtn.selected = YES;
            [deledArr addObject:imageA[j]];//把要删除的图片加入删除数组
            NSLog(@"first");
            
        }else{
            cell.chooseBtn.selected = NO;
            [deledArr removeObject:imageA[j]];//把要删除的图片从删除数组中删除
            NSLog(@"second");
        }
        
    }else
    {
        int i = imageSender.view.tag/1000;//分区
        int j = imageSender.view.tag%1000;
        
        PhotoModel *model = arrData[i-1];
        NSArray *jArr = [model.networkaddress componentsSeparatedByString:@","];
        [deledArr removeObject:jArr[j]];
        [deledArr insertObject:jArr[j] atIndex:0];
        
        NSString *strAllimg = [NSString stringWithString:deledArr[0]];
        for (int kkk = 1; kkk<deledArr.count; kkk++) {
            strAllimg = [strAllimg stringByAppendingFormat:@",%@",deledArr[kkk]];
        }
        ImageModel *model1 = [[ImageModel alloc]init];
        model1.imagename = strAllimg;
        
        ShowPhotoViewController * showVC =[[ShowPhotoViewController alloc]initWithNibName:@"ShowPhotoViewController" bundle:nil];
        
        showVC.model = model1;
        
        [self.navigationController pushViewController:showVC animated:NO];
        
        
        
        }
        

}





@end
