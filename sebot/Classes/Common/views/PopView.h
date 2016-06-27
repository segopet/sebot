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
    

    UIButton * _cancelBtn;
    
}
@property (strong)UIView *ParentView;
@property (nonatomic,strong)UIButton * saomaBtnl;
@property (nonatomic,strong)UIButton * sureBtn;
@property (nonatomic,strong)UITextField * numberTextfied;
@property (nonatomic,strong)UILabel * handLable;
@property (nonatomic,strong) UILabel * numberLable;


@property (nonatomic,assign)id<PopDelegate>delegate;

@end
