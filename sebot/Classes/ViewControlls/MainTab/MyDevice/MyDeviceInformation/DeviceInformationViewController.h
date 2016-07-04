//
//  DeviceInformationViewController.h
//  sebot
//
//  Created by yulei on 16/6/16.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTabViewController.h"
#import "PerInformationTableViewCell.h"


@interface DeviceInformationViewController : BaseTabViewController
@property (strong, nonatomic) IBOutlet UIButton *startBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (nonatomic,strong)NSString * didNumber;




@end
