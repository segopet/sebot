//
//  PopView.m
//  sebot
//
//  Created by yulei on 16/6/16.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "PopView.h"

@implementation PopView
{
    
    
}
@synthesize ParentView = _parentView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent: 0.75f];
       // self.layer.cornerRadius = 5.0f;
        self.layer.borderColor =GRAY_COLOR.CGColor;
        self.layer.borderWidth = 1;
        
        // 添加设备
        _handLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 30)];
        _handLable.numberOfLines = 0;
        _handLable.textAlignment = NSTextAlignmentCenter;
        _handLable.font = [UIFont systemFontOfSize:14];
        _handLable.textColor = [UIColor whiteColor];
        _handLable.backgroundColor = [UIColor clearColor];
        _handLable.text =NSLocalizedString(@"DVaddDevice", nil);
        [self addSubview:_handLable];
        
        // 设备号
        _numberLable =[[UILabel alloc]initWithFrame:CGRectMake(0, 30, 60, 30)];
        _numberLable.text =NSLocalizedString(@"DVDevicenum", nil);
        _numberLable.textColor =[UIColor redColor];
        [self addSubview:_numberLable];
        
        // 设备号数字
        _numberTextfied =[[UITextField alloc]initWithFrame:CGRectMake(60, 30, 100, 30)];
        _numberTextfied.text =@"123244";
        [self addSubview:_numberTextfied];
        
        
        _saomaBtnl =[[UIButton alloc]initWithFrame:CGRectMake(220, 30, 30, 30)];
        
        [_saomaBtnl setImage:[UIImage imageNamed:@"tab_square_normal"] forState:UIControlStateNormal];
        [_saomaBtnl addTarget:self action:@selector(saomao) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_saomaBtnl];
        
        _cancelBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 60, 130, 30)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.layer.borderWidth =1;
        _cancelBtn.layer.borderColor =[UIColor blackColor].CGColor;
        [_cancelBtn addTarget:self action:@selector(cancelBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelBtn];
        
        _sureBtn =[[UIButton alloc]initWithFrame:CGRectMake(130, 60, 130, 30)];
        [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        _sureBtn.layer.borderWidth =1;
        [_sureBtn addTarget:self action:@selector(surebtn) forControlEvents:UIControlEventTouchUpInside];
        
        _sureBtn.layer.borderColor =[UIColor blackColor].CGColor;
        [self addSubview:_sureBtn];
        
        
        
        
        
    }
    return self;
}

/**
 *  扫码
 */
- (void)saomao
{
    
    if (self.delegate) {
        //
        [self.delegate saomaMehod];
    }
    
    
}


- (void)cancelBtn
{
    
    
    if (self.delegate) {
        //
        [self.delegate cancelMehod];
    }

   
}


- (void)surebtn
{
    if (self.delegate) {
        //
        [self.delegate sureMehod];
    }

    
}

@end
