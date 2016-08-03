//
//  InCallViewController.m
//  sebot
//
//  Created by yulei on 16/6/24.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "InCallViewController.h"
#import "UIButton+EnlargeTouchArea.h"
#import "AFHttpClient+DeviceInformation.h"
@interface InCallViewController ()

{
    NSTimer *updateTimer;
    NSTimer * moveTimer;
    BOOL isLeft;
    
}
@property (nonatomic, assign) SephoneCall *call;

@end

@implementation InCallViewController
@synthesize call;
@synthesize otherView;
@synthesize ActView;

- (void)setCall:(SephoneCall *)acall {
    call = acall;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Set observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callUpdateEvent:) name:kSephoneCallUpdate object:nil];
    
    // Update on show
    SephoneCall *call_ = sephone_core_get_current_call([SephoneManager getLc]);
    SephoneCallState state = (call != NULL) ? sephone_call_get_state(call_) : 0;
    [self callUpdate:call_ state:state animated:FALSE];
    
    otherView.transform = CGAffineTransformScale(self.otherView.transform, 1.2, 1.0);
    // 视频
    sephone_core_set_native_video_window_id([SephoneManager getLc], (unsigned long)otherView);
    [self.ActView startAnimating];
    // 创建定时器更新通话时间 (以及创建时间显示)
    updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateViews) userInfo:nil repeats:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)name:UIApplicationWillResignActiveNotification object:nil]; //监听是否触发home键挂起程序.
    
    
    
}





- (void)callStream:(SephoneCall *)calls
{
    
    if (calls != NULL) {
        
        sephone_call_set_next_video_frame_decoded_callback(calls, hideSpinner, (__bridge void *)(self));
    }
    
    
    if (![SephoneManager hasCall:calls]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
}


// 更新控件内容
- (void)updateViews {
    
    SephoneCall *calltime= sephone_core_get_current_call([SephoneManager getLc]);
    
    if (calltime == NULL) {
        return;
    }else
    {
        int duration = sephone_call_get_duration(calltime);
        if (duration >= 300) {
            [SephoneManager terminateCurrentCallOrConference];
            NSLog(@"五分钟到时视频流自动断开");
        }
        
        
    }
    if (call == NULL) {
        return;
    }
    
    
}

- (void)applicationWillResignActive:(NSNotification *)notification

{
    
    [self RefreshCellForLiveId];
    
    
    
}
-(void)dealloc {
    [moveTimer invalidate];
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (void)RefreshCellForLiveId
{
    
    [SephoneManager terminateCurrentCallOrConference];
    [moveTimer invalidate];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}



// 通话监听

- (void)callUpdate:(SephoneCall *)call_ state:(SephoneCallState)state animated:(BOOL)animated {
    
    
    
    // Fake call update
    if (call_ == NULL) {
        return;
    }
    
    switch (state) {
            // 通话结束或出错时退出界面。
        case SephoneCallEnd:
        case SephoneCallError: {
            call = NULL;
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}



- (void)callUpdateEvent:(NSNotification *)notif {
    SephoneCall *call_ = [[notif.userInfo objectForKey:@"call"] pointerValue];
    SephoneCallState state = [[notif.userInfo objectForKey:@"state"] intValue];
    [self callUpdate:call_ state:state animated:TRUE];
}



// 用户体验设置

- (void)hideSpinnerIndicator:(SephoneCall *)call {
    
    self.ActView.hidden = YES;
    
    
}

static void hideSpinner(SephoneCall *call, void *user_data) {
    InCallViewController *thiz = (__bridge InCallViewController *)user_data;
    [thiz hideSpinnerIndicator:call];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    self.repairTitle.title = self.titileStr;

    
    
}

- (IBAction)backBtn:(UIButton *)sender {
    
    [SephoneManager terminateCurrentCallOrConference];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/**
 *  继承base
 */
- (void)setupData
{
    [super setupData];
    
}

- (void)setupView
{
    [super setupView];
   // [self.updownBtn setEnlargeEdgeWithTop:40 right:40 bottom:40 left:40];
     [self prefersStatusBarHidden];
    
    
    
}


// 重写
- (BOOL)prefersStatusBarHidden
{
    // iOS7后,[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    // 已经不起作用了
    return YES;
}




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self updateDeviceUseMember];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    if (updateTimer != nil) {
        [updateTimer invalidate];
        updateTimer = nil;
    }
    
    [moveTimer invalidate];
    
    // Clear windows
    //  必须清除，否则会因为arc导致再次视频通话时crash。
    sephone_core_set_native_video_window_id([SephoneManager getLc], (unsigned long)NULL);
    // Remove observer
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSephoneCallUpdate object:nil];

}


#pragma mark -- 硬件控制


/**
 * 上下左右
 */
- (IBAction)leftBtn:(UIButton *)sender {
      [self overTime];
    
   
}
- (IBAction)left_Start_btn:(UIButton *)sender {

     [self moveRobot:@"2"];
     NSLog(@"这是在往左走");
}

- (IBAction)rightBtn:(UIButton *)sender {
      [self overTime];
    
}


- (IBAction)right_start_btn:(UIButton *)sender {
   
     [self moveRobot:@"1"];
     NSLog(@"这是在往右走");
    
}

- (IBAction)topBtn:(UIButton *)sender {
      [self overTime];
    
}
- (IBAction)top_start_btn:(UIButton *)sender {
  
     [self moveRobot:@"4"];
     NSLog(@"这是在往上走");
    
}


- (IBAction)test:(UIButton *)sender {
  
    [self moveRobot:@"3"];
}


- (IBAction)test1:(UIButton *)sender {
    [self overTime];
}

// 头部

- (IBAction)upTopBtn:(UIButton *)sender {
     [self overTime];
  
}
- (IBAction)uptop_start_btn:(UIButton *)sender {
    
      [self moverobot:@"1"]; // 上
  
}

- (IBAction)upDownBtn:(UIButton *)sender {
    
    [self overTime];
   
}

- (IBAction)stratBtnDown:(UIButton *)sender {
    
    [self moverobot:@"2"]; // 下
}

- (void)overTime
{
     [moveTimer invalidate];
    self.up_btn.userInteractionEnabled = YES;
    self.down_btn.userInteractionEnabled = YES;
    self.left_btn.userInteractionEnabled = YES;
    self.right_btn.userInteractionEnabled = YES;
    self.left_up_btn.userInteractionEnabled = YES;
    self.left_down_btn.userInteractionEnabled = YES;
    
}

#pragma sendMessageTest wjb


- (void)moveRobot:(NSString *)str
{
    NSInteger i = [str integerValue];
    switch (i) {
        case 4:
            // 上
            self.up_btn.userInteractionEnabled = YES;
            self.down_btn.userInteractionEnabled = NO;
            self.left_btn.userInteractionEnabled = NO;
            self.right_btn.userInteractionEnabled = NO;
            self.left_up_btn.userInteractionEnabled = NO;
            self.left_down_btn.userInteractionEnabled = NO;
            break;
        case 3:
             //下
            self.down_btn.userInteractionEnabled = YES;
            self.up_btn.userInteractionEnabled = NO;
            self.left_btn.userInteractionEnabled = NO;
            self.right_btn.userInteractionEnabled = NO;
            self.left_up_btn.userInteractionEnabled = NO;
            self.left_down_btn.userInteractionEnabled = NO;
            break;
        case 2:
            //左
            self.left_btn.userInteractionEnabled = YES;
            self.right_btn.userInteractionEnabled = NO;
            self.down_btn.userInteractionEnabled = NO;
            self.up_btn.userInteractionEnabled = NO;
            self.left_up_btn.userInteractionEnabled = NO;
            self.left_down_btn.userInteractionEnabled = NO;
            break;
        case 1:
            // 右
            self.right_btn.userInteractionEnabled = YES;
            self.left_btn.userInteractionEnabled = NO;
            self.up_btn.userInteractionEnabled = NO;
            self.down_btn.userInteractionEnabled = NO;
            self.left_up_btn.userInteractionEnabled = NO;
            self.left_down_btn.userInteractionEnabled = NO;
            break;
            
        default:
            break;
    }
    
   
    moveTimer = [HWWeakTimer scheduledTimerWithTimeInterval:1.0*0.2 block:^(id userInfo) {
        
        [self sendInfomation:str];
    } userInfo:@"Fire" repeats:YES];
    [moveTimer fire];
    
}

// 左右

-(void)moverobot:(NSString *)str
{
     NSInteger i = [str integerValue];
    switch (i) {
        case 1:
            self.right_btn.userInteractionEnabled = NO;
            self.left_btn.userInteractionEnabled = NO;
            self.up_btn.userInteractionEnabled = NO;
            self.down_btn.userInteractionEnabled = NO;
            self.left_up_btn.userInteractionEnabled = YES;
            self.left_down_btn.userInteractionEnabled = NO;
            break;
            
        case 2:
            self.right_btn.userInteractionEnabled = NO;
            self.left_btn.userInteractionEnabled = NO;
            self.up_btn.userInteractionEnabled = NO;
            self.down_btn.userInteractionEnabled = NO;
            self.left_up_btn.userInteractionEnabled = NO;
            self.left_down_btn.userInteractionEnabled = YES;
            
            break;
        default:
            break;
    }
    
    
    moveTimer = [HWWeakTimer scheduledTimerWithTimeInterval:1.0*0.2 block:^(id userInfo) {
        
        [self sendInfomationL:str];
    } userInfo:@"Fire" repeats:YES];
    [moveTimer fire];

    
}


- (void)sendInfomationL:(NSString *)sender
{
    
   NSString * msg =[NSString stringWithFormat:@"control_servo,0,0,2,%d,200",[sender intValue]];
    NSLog(@"我走");
    [self sendMessage:msg];
}

- (void)sendInfomation:(NSString *)sender
{
 
    NSString * msg =[NSString stringWithFormat:@"control_servo,0,0,1,%d,200",[sender intValue]];
    [self sendMessage:msg];
    
    
}


-(void) sendMessage:(NSString *)mess{
    
    const char * message =[mess UTF8String];
    sephone_core_send_user_message([SephoneManager getLc], message);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (void)updateDeviceUseMember
{
    // 结束通话 更新设备使用记录
    NSUserDefaults * defu =[NSUserDefaults standardUserDefaults];
    NSString * str = [AccountManager sharedAccountManager].loginModel.userid;
    [[AFHttpClient sharedAFHttpClient]updateDevice:str token:str did: [defu objectForKey:@"contentID"] complete:^(ResponseModel * model) {
        
        NSLog(@"更新成功");
        
    }];
    
    
}



@end
