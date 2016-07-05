//
//  InCallViewController.m
//  sebot
//
//  Created by yulei on 16/6/24.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "InCallViewController.h"

@interface InCallViewController ()

{
    NSTimer *updateTimer;
    
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

- (void)RefreshCellForLiveId
{
    
    [SephoneManager terminateCurrentCallOrConference];
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
    // Do any additional setup after loading the view from its nib.
  //  [self setNavTitle: NSLocalizedString(@"tabDevice", nil)];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
   
    
    
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
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    if (updateTimer != nil) {
        [updateTimer invalidate];
        updateTimer = nil;
    }
    
    // Clear windows
    //  必须清除，否则会因为arc导致再次视频通话时crash。
    sephone_core_set_native_video_window_id([SephoneManager getLc], (unsigned long)NULL);
    // Remove observer
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSephoneCallUpdate object:nil];

}


#pragma mark -- 硬件控制

- (IBAction)leftBtn:(UIButton *)sender {
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (void)updateDeviceUseMember
{
    // 结束通话 更新设备使用记录
    // "object": "主叫对象(mobile 移动客户端/device 设备端)"
    [[AFHttpClient sharedAFHttpClient]POST:@"sebot/moblie/forward" parameters:@{@"userid" : [AccountManager sharedAccountManager].loginModel.userid , @"objective":@"device", @"token" : @"1",@"action":@"addCallRecords",@"data":@{@"calling":@"1",@"called":@"9000000006",@"object":@""}} result:^(id model) {
        
        NSLog(@"%@",model[@"retDesc"]);
        
    }];
    
}



@end
