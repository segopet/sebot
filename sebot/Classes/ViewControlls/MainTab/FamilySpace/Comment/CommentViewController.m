//
//  CommentViewController.m
//  sebot
//
//  Created by czx on 16/7/19.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "CommentViewController.h"
#import "AFHttpClient+Comment.h"
#import "CommentTableViewCell.h"
#import "CommentModel.h"
#import "DetailCommentCell.h"


static NSString * cellId = @"commenttableviewCellides";
@interface CommentViewController ()
@property (nonatomic,strong)NSMutableArray * listArray;
@property (nonatomic,strong)NSMutableArray * lablearr;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"评论"];
    _listArray = [[NSMutableArray alloc]init];
    _lablearr =[NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(void)setupView{
    [super setupView];
    self .tableView.frame =  CGRectMake(0, 0, self.view.width, self.view.height - NAV_BAR_HEIGHT);
    [self.tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.backgroundColor = LIGHT_GRAY_COLOR;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self initRefreshView];

}

-(void)setupData{
    [super setupData];
   
}

-(void)loadDataSourceWithPage:(int)page{
    [[AFHttpClient sharedAFHttpClient]quserCommentWithUserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid wid:self.wid ptype:@"a" page:[NSString stringWithFormat:@"%d",page] complete:^(ResponseModel *model) {
        if (model) {
            
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
        }
        
    }];

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
    
    CommentModel* model = self.dataSource[indexPath.row];
    
    NSMutableArray * array = model.list;
    
    NSString * str1 = model.content;
    CGSize lableSize1 = {0,0};
    lableSize1 = [str1 sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200.0, 5000) lineBreakMode:NSLineBreakByWordWrapping];
    
    if (array.count > 0 ) {
        NSString * str123 = [NSString new];
        for (int i = 0 ; i < array.count; i++) {
          str123 = array[i][@"content"];
        }
        CGSize labelSize1112 = {0,0};
        labelSize1112 = [str123 sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200.0, 5000) lineBreakMode:NSLineBreakByWordWrapping];;
         return 90 * W_Hight_Zoom + 20 * array.count * W_Hight_Zoom + lableSize1.height + labelSize1112.height;
    }else{
        return 90 * W_Hight_Zoom + 20 * array.count * W_Hight_Zoom + lableSize1.height;
    }
 }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentModel* model = self.dataSource[indexPath.row];
    NSMutableArray * listArray = model.list;
    
     CommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }else{
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
        
    }
    
    [cell.headImage.layer setMasksToBounds:YES];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.headportrait] placeholderImage:[UIImage imageNamed:@"默认头像.png"]];
    cell.nameLabel.frame = CGRectMake(70 * W_Wide_Zoom, 20 * W_Hight_Zoom, 0 * W_Wide_Zoom, 30 * W_Hight_Zoom);
    cell.nameLabel.text = [NSString stringWithFormat:@"%@:",model.username];
    NSString * nameStr = cell.nameLabel.text;
    CGSize nameSize = [nameStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    cell.nameLabel.width = nameSize.width;
    
    
    cell.contentLabel.frame = CGRectMake(CGRectGetMaxX(cell.nameLabel.frame) + 5 * W_Wide_Zoom, CGRectGetMinY(self.view.frame) + 27, 230 * W_Wide_Zoom, 30 * W_Hight_Zoom);
    cell.contentLabel.text = model.content;
    NSString * str111 = model.content;
    CGSize labelSize111 = {0,0};
    labelSize111 = [str111 sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200.0, 5000) lineBreakMode:NSLineBreakByWordWrapping];;
    cell.contentLabel.numberOfLines = 0;
    cell.contentLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    cell.contentLabel.frame = CGRectMake(cell.contentLabel.frame.origin.x, CGRectGetMinY(self.view.frame) + 27, cell.contentLabel.frame.size.width, labelSize111.height);
    
    
    cell.timelabel.frame = CGRectMake(70 * W_Wide_Zoom, CGRectGetMaxY(cell.contentLabel.frame), 150 * W_Wide_Zoom, 30 * W_Hight_Zoom);
    cell.timelabel.text = model.opttime;
    //回复的东西
    
    for (int i = 0 ; i < listArray.count; i++) {
        
        //拿出回复的内容
        NSString * str123 = listArray[i][@"content"];
        //计算其高度
        CGSize labelSize1112 = {0,0};
        labelSize1112 = [str123 sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200.0, 5000) lineBreakMode:NSLineBreakByWordWrapping];;
        
        //labelSize1112.height 就是它的高度
        
        //计算回复内容的长度
        int jj = [self convertToInt1:str123];

        //计算行数(12个字一行－ ＝)
        int kk = jj/12;
        float gg = jj%12;
        NSLog(@" ======= ======= %d,%f",kk,gg);
        int rr;
        if (kk>0) {
            //行数
            rr = kk + 1;
        }else{
            rr = 0;
        }
        //这儿的问题是：我拿到了这一行字的行数，但是只能改变这一行的位置，我想改变它下面那一行的位置，把下面那一行加上 rr * 20 ，但是写了半天，不知道怎么拿到kk>0的时候下面那一行－ ＝
        
        
        cell.firstname = [[UILabel alloc]initWithFrame:CGRectMake(70 * W_Wide_Zoom,  CGRectGetMaxY(cell.timelabel.frame)+ i * 20 , 0 * W_Wide_Zoom, 30 * W_Hight_Zoom)];

        cell.firstname.font = [UIFont systemFontOfSize:14];
        cell.firstname.textColor = RED_COLOR;
        cell.firstname.text = listArray[i][@"username"];
        cell.firstname.tag = 300+i;
        NSString * strr = listArray[i][@"username"];
        CGSize titleSize = [strr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        cell.firstname.width = titleSize.width;
        [cell.contentView addSubview:cell.firstname];
        
        
        
        
        
        
        
        
        
        UILabel * huifuLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cell.firstname.frame)+ 2 * W_Wide_Zoom, CGRectGetMaxY(cell.timelabel.frame)+ i * 20 * W_Hight_Zoom , 0 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        huifuLabel.tag = 10000+i;
        huifuLabel.textColor = [UIColor blackColor];
        huifuLabel.font = [UIFont systemFontOfSize:14];
        huifuLabel.text = @"回复";
        huifuLabel.tag = 1000001+i;
        NSString * strr1 = huifuLabel.text;
        CGSize titleSize1 = [strr1 sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        huifuLabel.width = titleSize1.width;
        [cell.contentView addSubview:huifuLabel];
        
        UILabel * lastName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(huifuLabel.frame) + 2 * W_Wide_Zoom,CGRectGetMaxY(cell.timelabel.frame)+ i * 20 * W_Hight_Zoom, 0 * W_Wide_Zoom, 30 * W_Hight_Zoom)];

        lastName.textColor = RED_COLOR;
        lastName.font = [UIFont systemFontOfSize:14];
        lastName.text = [NSString stringWithFormat:@"%@:",listArray[i][@"bname"]];
        NSString * strr2 = lastName.text;
         CGSize titleSize2 = [strr2 sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        lastName.width = titleSize2.width;
        [cell.contentView addSubview:lastName];
        
        UILabel * lastContentlabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lastName.frame) + 3 * W_Wide_Zoom, CGRectGetMaxY(cell.timelabel.frame)+7 * W_Hight_Zoom + i * 20 * W_Hight_Zoom, 180 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        lastContentlabel.textColor = [UIColor blackColor];
        lastContentlabel.font = [UIFont systemFontOfSize:14];
        lastContentlabel.text = listArray[i][@"content"];

        lastContentlabel.numberOfLines = 0;
        lastContentlabel.lineBreakMode = UILineBreakModeCharacterWrap;
        lastContentlabel.frame = CGRectMake(lastContentlabel.frame.origin.x, lastContentlabel.frame.origin.y, lastContentlabel.frame.size.width, labelSize1112.height);
        [cell.contentView addSubview:lastContentlabel];
        
        
    }
    
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
    return cell;
}


-  (int)convertToInt:(NSString*)strtemp {
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
    
}


-  (int)convertToInt1:(NSString*)strtemp {
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
    
}



@end