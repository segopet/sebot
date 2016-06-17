//
//  PopView.h
//  sebot
//
//  Created by yulei on 16/6/16.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopDelegate <NSObject>

- (void)saomaMehod;
- (void)cancelMehod;
- (void)sureMehod;


@end


@interface PopView : UIView
{
    
    UILabel * _handLable;
    UILabel * _numberLable;
    UITextField * _numberTextfied;
    
    UIButton * _cancelBtn;
    UIButton * _sureBtn;
    
}
@property (strong)UIView *ParentView;
@property (nonatomic,strong)UIButton * saomaBtnl;
@property (nonatomic,assign)id<PopDelegate>delegate;

@end
