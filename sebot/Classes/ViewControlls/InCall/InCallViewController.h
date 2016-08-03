//
//  InCallViewController.h
//  sebot
//
//  Created by yulei on 16/6/24.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "BaseViewController.h"
#import "HWWeakTimer.h"

@interface InCallViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *otherView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *ActView;

- (void)setCall:(SephoneCall *)acall;

@property (strong, nonatomic) IBOutlet UIButton *updownBtn;
@property (strong, nonatomic) IBOutlet UINavigationBar *titleBar;
@property (nonatomic,strong)NSString * titileStr;

@property (strong, nonatomic) IBOutlet UINavigationItem *repairTitle;


@property (strong, nonatomic) IBOutlet UIButton *up_btn;
@property (strong, nonatomic) IBOutlet UIButton *left_btn;
@property (strong, nonatomic) IBOutlet UIButton *down_btn;
@property (strong, nonatomic) IBOutlet UIButton *right_btn;

// button

@property (strong, nonatomic) IBOutlet UIButton *left_up_btn;
@property (strong, nonatomic) IBOutlet UIButton *left_down_btn;

@end
