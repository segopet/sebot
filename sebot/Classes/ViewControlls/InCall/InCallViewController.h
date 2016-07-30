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

@end
