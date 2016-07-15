//
//  RepairPwViewController.h
//  sebot
//
//  Created by yulei on 16/6/17.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "BaseViewController.h"

@interface RepairPwViewController : BaseViewController<UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITextField *ageinNewPsTx;

@property (strong, nonatomic) IBOutlet UITextField *NewPsTx;

@property (strong, nonatomic) IBOutlet UITextField *oldPsTx;
@property (strong, nonatomic) IBOutlet UIButton *updateBtn;
@end
