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

static NSString * cellId = @"FamilyCellides";
@implementation FamilySpaceViewcontroller


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"tabFamily", nil)];
     self.view.backgroundColor = [UIColor whiteColor];
    [self showBarButton:NAV_RIGHT title:NSLocalizedString(@"navUpdateimage", nil) fontColor:[UIColor redColor]];

}

-(void)setupView{
    [super setupView];
    self .tableView.frame =  CGRectMake(0, 0, self.view.width, self.view.height - NAV_BAR_HEIGHT);
    [self.tableView registerClass:[FamilyTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self initRefreshView];
        
    
    
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

      //tabview隐藏点击效果和分割线
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//点赞
-(void)dianzanbttuntouch:(UIButton *)sender{
    NSInteger i = sender.tag - 22;
    FamilyquanModel * model = self.dataSource[i];
    if (sender.selected == YES) {
        NSLog(@"gaga");
        [[AppUtil appTopViewController] showHint:@"您已经点过赞了，不能重复点赞哦!"];
    }else{
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



-(void)doRightButtonTouch{ 
    NewPhotoalbumViewController * newVc = [[NewPhotoalbumViewController alloc]init];
    [self.navigationController pushViewController:newVc animated:NO];
}




@end
