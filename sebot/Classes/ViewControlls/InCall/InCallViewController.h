//
//  InCallViewController.h
//  sebot
//
//  Created by yulei on 16/6/24.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "BaseViewController.h"

@interface InCallViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *otherView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *ActView;
@property (strong, nonatomic) IBOutlet UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIButton *RightBtn;
// 上下左右(轮子)
@property (strong, nonatomic) IBOutlet UIButton *LeftMoveBtn;
// 头部（前后）
@property (strong, nonatomic) IBOutlet UIButton *RightMove;

@end
