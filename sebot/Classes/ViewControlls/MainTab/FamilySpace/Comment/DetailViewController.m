//
//  DetailViewController.m
//  sebot
//
//  Created by czx on 16/7/25.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "DetailViewController.h"
#import "AFHttpClient+Comment.h"
#import "CommentInputView.h"
#import "DetailCommentCell.h"
#import "IQKeyboardManager.h"

//按照以前的方法来写看
@interface DetailViewController ()<UITextFieldDelegate>
{
    NSIndexPath *currentEditingIndexthPath;
}
@property (nonatomic, strong) CommentInputView *commentInputView;
@property (nonatomic,strong)UITextField * ceishi;
@property (nonatomic, strong) UIView* toolView;
@property (nonatomic,strong)UITextField * downField;

@end
NSString * const kDetailCommentCellID = @"DetailCommentCell";
@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"评论"];
    // Do any additional setup after loading the view.
     [IQKeyboardManager sharedManager].enable = NO;
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)setupView{
    [super setupView];
    self .tableView.frame =  CGRectMake(0, 0, self.view.width, self.view.height - NAV_BAR_HEIGHT);
    [self.tableView registerClass:[DetailCommentCell class] forCellReuseIdentifier:kDetailCommentCellID];
    self.tableView.backgroundColor = LIGHT_GRAY_COLOR;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
      [self.view addSubview:self.toolView];
    [self.view addSubview:self.commentInputView];
    
    [self initRefreshView];
    // [IQKeyboardManager sharedManager].enable = NO;
    
 

    
    
}

-(UIView *)toolView{
    
    _toolView = [[UIView alloc] initWithFrame:CGRectMake(0 * W_Wide_Zoom, 618 * W_Hight_Zoom, self.tableView.width, 49 * W_Hight_Zoom)];
    _toolView.backgroundColor = LIGHT_GRAY_COLOR;
    _toolView.layer.shadowColor = [UIColor blackColor].CGColor;
    _toolView.layer.shadowOffset = CGSizeMake(0, -1);
    _toolView.layer.shadowOpacity = 0.4;
    _toolView.layer.shadowRadius = 2;
    [self.view addSubview:_toolView];
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(3 * W_Wide_Zoom, 3 * W_Hight_Zoom, 369 * W_Wide_Zoom, 43 * W_Hight_Zoom)];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 3;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_toolView addSubview:button];
    [button handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.commentInputView showWithSendCommentBlock:^(NSString *text) {
            if (text && text.length > 0) {
                [[AFHttpClient sharedAFHttpClient]addCommentWithUserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid  pid:[AccountManager sharedAccountManager].loginModel.userid  bid:@"" wid:self.wid bcid:@"" ptype:@"a" action:@"p" content:text type:@"a" complete:^(ResponseModel *model) {
                    if (model) {
                        CommentModel* addModel = [[CommentModel alloc] init];
                        addModel.username = [AccountManager sharedAccountManager].loginModel.nickname;
                        addModel.content = text;
                       // addModel.age = [AccountManager sharedAccountManager].loginModel.pet_age;
                        //addModel.sex = [AccountManager sharedAccountManager].loginModel.pet_sex;
                        addModel.opttime = [AppUtil getCurrentTime];
                        //addModel.race = [AccountManager sharedAccountManager].loginModel.pet_race;
                        addModel.wid = self.wid;
                        addModel.cid = model.content;
                        addModel.headportrait = [AccountManager sharedAccountManager].loginModel.headportrait;
                        addModel.pid = [AccountManager sharedAccountManager].loginModel.userid;
                        [self.dataSource insertObject:addModel atIndex:0];
                        [self.tableView reloadData];
  
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                }];
        
        
            }
        }];
    }];
    
   


    return _toolView;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CommentModel* model = self.dataSource[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[DetailCommentCell class] contentViewWidth:SCREEN_WIDTH];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel* commentModel = self.dataSource[indexPath.row];
    DetailCommentCell* cell = [tableView dequeueReusableCellWithIdentifier:kDetailCommentCellID];
    cell.commentLableClickBlock = ^(int index){
        self.toolView.hidden = YES;
        currentEditingIndexthPath = [self.tableView indexPathForCell:cell];
        [self.commentInputView showWithSendCommentBlock:^(NSString *text) {
            if (text && text.length > 0) {
                //回复评论的model
                CommentModel* replayCommentModel = commentModel.list[index];
                [[AFHttpClient sharedAFHttpClient]addCommentWithUserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid  pid:[AccountManager sharedAccountManager].loginModel.userid bid:replayCommentModel.pid  wid:self.wid bcid:commentModel.cid ptype:@"r" action:@"h" content:text type:@"a" complete:^(ResponseModel *model) {
                    if (model) {
                CommentModel* addModel = [[CommentModel alloc] init];
                addModel.username = [AccountManager sharedAccountManager].loginModel.nickname;
                addModel.content = text;
                addModel.opttime = [AppUtil getCurrentTime];
                addModel.wid = self.wid;
                addModel.cid = model.content;
                addModel.bcid = commentModel.cid;
                addModel.bname = replayCommentModel.username;
              //  addModel.img = [AccountManager sharedAccountManager].loginModel.headportrait;
                addModel.pid = [AccountManager sharedAccountManager].loginModel.userid;
                [commentModel.list addObject:addModel];
                [self.tableView reloadRowsAtIndexPaths:@[currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
                
            }

                    
                
                }];
            }
        }];
    };
    cell.replyBlock = ^(){
        self.toolView.hidden = YES;
        currentEditingIndexthPath = [self.tableView indexPathForCell:cell];
        [self.commentInputView showWithSendCommentBlock:^(NSString *text) {
            if (text && text.length > 0) {

                [[AFHttpClient sharedAFHttpClient]addCommentWithUserid:[AccountManager sharedAccountManager].loginModel.userid token:[AccountManager sharedAccountManager].loginModel.userid  pid:[AccountManager sharedAccountManager].loginModel.userid bid:commentModel.pid  wid:self.wid bcid:commentModel.cid ptype:@"r" action:@"h" content:text type:@"a" complete:^(ResponseModel *model) {
                    if (model) {
                        CommentModel* addModel = [[CommentModel alloc] init];
                        addModel.username = [AccountManager sharedAccountManager].loginModel.nickname;
                        addModel.content = text;
                        addModel.opttime = [AppUtil getCurrentTime];
                        addModel.wid = self.wid;
                        addModel.cid = model.content;
                        addModel.bcid = commentModel.cid;
                        //addModel.img = [AccountManager sharedAccountManager].loginModel.headportrait;
                        addModel.pid = [AccountManager sharedAccountManager].loginModel.userid;

                        [commentModel.list addObject:addModel];
                        [self.tableView reloadRowsAtIndexPaths:@[currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }];
                
            }
        }];
    };


    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    cell.model = commentModel;
    
    return cell;
}
- (CommentInputView *)commentInputView{
    
    if (!_commentInputView) {
        _commentInputView = [[CommentInputView alloc] initWithFrame:CGRectMake(0, self.view.height - [CommentInputView defaultHeight], self.view.width, [CommentInputView defaultHeight])];
        _commentInputView.viewController = self;
    }
    
    return _commentInputView;
}

- (void)keyboardNotification:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGRect textFieldRect = CGRectMake(0, rect.origin.y - self.commentInputView.height , rect.size.width, self.commentInputView.height);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }
    
    self.commentInputView.frame = textFieldRect;
}

-(void)doLeftButtonTouch{
    [super doLeftButtonTouch];
     [[NSNotificationCenter defaultCenter]postNotificationName:@"shuaxinn12" object:nil];
}
@end