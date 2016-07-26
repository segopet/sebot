//
//  FamilySpaceViewcontroller.m
//  sebot
//
//  Created by yulei on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "FamilySpaceViewcontroller.h"
#import "NewPhotoalbumViewController.h"
#import "FamilyTableViewCell.h"
#import "AFHttpClient+Alumb.h"
#import "FamilyquanModel.h"
#import "UIImage-Extensions.h"
#import "LargeViewController.h"
#import "PopView.h"
#import "CommentViewController.h"
#import "SaomaoViewController.h"
#import "AFHttpClient+MyDevice.h"

#import "DetailViewController.h"


static NSString * cellId = @"FamilyCellides";
@interface FamilySpaceViewcontroller ()<PopDelegate>
{
    PopView * _popView;
    AppDelegate *app;
    NSMutableArray * _listArray;
    UIImageView * _image;
}
@end


@implementation FamilySpaceViewcontroller

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dada) name:@"shuaxinn" object:nil];
    //shuaxinn12
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dada1) name:@"shuaxinn12" object:nil];
        //bangdingshuaxin
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dada3) name:@"bangdingshuaxin" object:nil];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(void)dada{
    [self initRefreshView];
}
-(void)dada1{

    [self loadDataSourceWithPage:1];

}

-(void)dada3{
    _listArray = [NSMutableArray array];
    [self isbangding];
 //fuc
}



- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"tabFamily", nil)];
     self.view.backgroundColor = [UIColor whiteColor];
    
    [self showBarButton:NAV_RIGHT imageName:@"相机.png"];
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _popView = [[PopView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT)];
    _popView.center = self.view.center;
    _popView.ParentView = app.window;
    _popView.delegate = self;
    _listArray = [NSMutableArray array];
    [self isbangding];
}

-(void)setupView{
    [super setupView];
    
    
}
-(void)doRightButtonTouch{

    if (_listArray.count > 0) {
        NewPhotoalbumViewController * newVc = [[NewPhotoalbumViewController alloc]init];
        [self.navigationController pushViewController:newVc animated:NO];
    }else{
         [self.view addSubview:_popView];
    }
 
}

-(void)isbangding{
    [[AFHttpClient sharedAFHttpClient]querMydeviceWithUserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid complete:^(ResponseModel *model) {
        [_listArray addObjectsFromArray:model.list];
        if (_listArray.count > 0 ) {
            [_image removeFromSuperview];
            self .tableView.frame =  CGRectMake(0, 0, self.view.width, self.view.height);
            [self.tableView registerClass:[FamilyTableViewCell class] forCellReuseIdentifier:cellId];
            self.tableView.backgroundColor = [UIColor whiteColor];
            [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            [self initRefreshView];
        }else{
            [self noBangdingView];
        }
    }];

}

-(void)bangdingView{
 

}

-(void)noBangdingView{
    _image = [[UIImageView alloc]initWithFrame:CGRectMake(60 * W_Wide_Zoom, 200 * W_Hight_Zoom, 250 * W_Wide_Zoom, 250 * W_Hight_Zoom)];
    _image.image = [UIImage imageNamed:@"无图时.png"];
    [self.view addSubview:_image];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有绑定设备，请立即绑定设备？" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.view addSubview:_popView];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)loadDataSourceWithPage:(int)page{
    [[AFHttpClient sharedAFHttpClient]familyArticlesWithUserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid page:[NSString stringWithFormat:@"%d",page] complete:^(ResponseModel *model) {

        if (page == START_PAGE_INDEX) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:model.list];
        } else {
            [self.dataSource addObjectsFromArray:model.list];
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



-(void)setupData{
    [super setupData];

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
    return 400*W_Hight_Zoom;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FamilyquanModel * model = self.dataSource[indexPath.row];
    FamilyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.namelabel.text = model.nickname;
    cell.content.text = model.content;
    [cell.headImage.layer setMasksToBounds:YES];
    NSString * headStr = model.headportrait;
    NSURL * headUrl = [NSURL URLWithString:headStr];
    [cell.headImage sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@"默认头像.png"]];
    //这里不仅要这样写，cell里面要把这个图片的 contentMode = UIViewContentModeCenter，layer.masksToBounds = YES;
    if (model.cutImage) {
        cell.bigImage.image = model.cutImage;
    }else{
        [cell.bigImage sd_setImageWithURL:[NSURL URLWithString:model.thumbnails] placeholderImage:[UIImage imageNamed:@"默认图片.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                cell.bigImage.image = [image imageByScalingProportionallyToSize:CGSizeMake(self.tableView.width, CGFLOAT_MAX)];
                model.cutImage = cell.bigImage.image;
            }

        }];
    }
    
    UIButton * bigBtn = [[UIButton alloc]initWithFrame:cell.bigImage.frame];
    bigBtn.backgroundColor = [UIColor clearColor];
    [cell addSubview:bigBtn];
    bigBtn.tag = indexPath.row + 21;
    [bigBtn addTarget:self action:@selector(lookPictureButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.timeLabel.text = model.publishtime;
    if ([model.praised isEqualToString:@"0"]) {
        [cell.aixin setImage:[UIImage imageNamed:@"dianzanzan.png"] forState:UIControlStateNormal];
        cell.aixin.selected = NO;
    }else{
        [cell.aixin setImage:[UIImage imageNamed:@"dianzanhou.png"] forState:UIControlStateNormal];
         cell.aixin.selected = YES;
    }
    cell.aixin.tag = indexPath.row + 22;
    [cell.aixin addTarget:self action:@selector(dianzanbttuntouch:) forControlEvents:UIControlEventTouchUpInside];
    cell.aixinLabel.text = model.praises;
    cell.pinglunlabel.text = model.comments;

    cell.pinglunBtn.tag = indexPath.row + 23;
    [cell.pinglunBtn addTarget:self action:@selector(pinglunbuttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    //tabview隐藏点击效果和分割线
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//评论
-(void)pinglunbuttonTouch:(UIButton *)sender{
    NSInteger i = sender.tag - 23;
    NSLog(@"%ld",i);
     FamilyquanModel * model = self.dataSource[i];
//    CommentViewController * commVc = [[CommentViewController alloc]init];
//    commVc.wid = model.aid;
//    [self.navigationController pushViewController:commVc animated:NO];
    DetailViewController * Vcc = [[DetailViewController alloc]init];
    Vcc.wid = model.aid;
    [self.navigationController pushViewController:Vcc animated:NO];
    
}

//点赞
-(void)dianzanbttuntouch:(UIButton *)sender{
    NSInteger i = sender.tag - 22;
    FamilyquanModel * model = self.dataSource[i];
    if (sender.selected == YES) {
        NSLog(@"gaga");
        [[AppUtil appTopViewController] showHint:@"您已经点过赞了，不能重复点赞哦!"];
    }else{
      [sender setImage:[UIImage imageNamed:@"dianzanhou.png"] forState:UIControlStateNormal];
    [[AFHttpClient sharedAFHttpClient]dianzanWithUserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid objid:model.aid objtype:@"a" complete:^(ResponseModel *model) {
        if (model) {
            [[AppUtil appTopViewController] showHint:model.retDesc];
            [self loadDataSourceWithPage:1];
        }
    }];
    }
}

//点击查看大图
-(void)lookPictureButtonTouch:(UIButton *)sender{
    NSInteger i = sender.tag - 21;
    NSLog(@"%ld",i);
    FamilyquanModel * model = self.dataSource[i];
    [[AFHttpClient sharedAFHttpClient]lookpictureWithUserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid aid:model.aid complete:^(ResponseModel *model) {
        if (model) {
             NSArray * array = model.list;
             LargeViewController * largeVC =[[LargeViewController alloc]initWithNibName:@"LargeViewController" bundle:nil];
            largeVC.dataArray = array;
            [self.navigationController pushViewController:largeVC animated:YES];
        }
    }];
}



/**
 * pop 代理
 */

- (void)saomaMehod
{
    
    NSLog(@"11");
    SaomaoViewController * saomoVC =[[SaomaoViewController alloc]initWithNibName:@"SaomaoViewController" bundle:nil];
    [self.navigationController pushViewController:saomoVC animated:YES];
    
    
}
- (void)cancelMehod
{
    
    NSLog(@"22");
    [_popView removeFromSuperview];
}
/**
 *  绑定
 */
- (void)sureMehod
{
    
    
    NSString * str = [AccountManager sharedAccountManager].loginModel.userid;
    
    if ([AppUtil isBlankString:_popView.numberTextfied.text]) {
        _popView.numberTextfied.text= [[NSUserDefaults standardUserDefaults]objectForKey:@"s_m_text"];
    }else
    {
        
    }
    [[AFHttpClient sharedAFHttpClient]addDevide:str token:str deviceno:_popView.numberTextfied.text complete:^(ResponseModel * model) {
        [_popView removeFromSuperview];
        [self showSuccessHudWithHint:model.retDesc];

      //  [self isbangding];
    }];
    
}



@end
