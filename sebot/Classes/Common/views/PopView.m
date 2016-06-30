//
//  PopView.m
//  sebot
//
//  Created by yulei on 16/6/16.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "PopView.h"


@interface PopView()
{
    
}
@end

@implementation PopView
{
    
    
}
@synthesize ParentView = _parentView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
      
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent: 0.55f];
       // self.layer.cornerRadius = 5.0f;
        self.layer.borderColor =GRAY_COLOR.CGColor;
        self.layer.borderWidth = 1;
        
        
        UIView * viewBG =[[UIView alloc]initWithFrame:CGRectMake(0, 80, 300, 150)];
        viewBG.center = self.center;
        viewBG.backgroundColor =[UIColor whiteColor];
        viewBG.layer.masksToBounds = YES;
        viewBG.layer.cornerRadius = 6;
        [self addSubview:viewBG];
        
        
        // 添加设备
        _handLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, 100, 30)];
        _handLable.numberOfLines = 0;
        _handLable.textAlignment = NSTextAlignmentCenter;
        _handLable.font = [UIFont systemFontOfSize:20];
        _handLable.textColor = [UIColor blackColor];
        _handLable.backgroundColor = [UIColor clearColor];
        _handLable.text =NSLocalizedString(@"DVaddDevice", nil);
        [viewBG addSubview:_handLable];
        
        // 设备号
        _numberLable =[[UILabel alloc]initWithFrame:CGRectMake(20, 55, 80, 30)];
        _numberLable.text =NSLocalizedString(@"DVDevicenum", nil);
        _numberLable.font =[UIFont systemFontOfSize:18];
        _numberLable.textColor =[UIColor blackColor];
        [viewBG addSubview:_numberLable];
        
        // 设备号数字
        _numberTextfied =[[UITextField alloc]initWithFrame:CGRectMake(90, 55, 180, 30)];
        _numberTextfied.placeholder = @"输入设备号";
        _numberTextfied.textAlignment =NSTextAlignmentLeft;
        _numberLable.font =[UIFont systemFontOfSize:18];
        [viewBG addSubview:_numberTextfied];
        
        
        _saomaBtnl =[[UIButton alloc]initWithFrame:CGRectMake(260, 5, 30, 30)];
        
        [_saomaBtnl setImage:[UIImage imageNamed:@"se_saomao"] forState:UIControlStateNormal];
        [_saomaBtnl addTarget:self action:@selector(saomao) forControlEvents:UIControlEventTouchUpInside];
        
        [viewBG addSubview:_saomaBtnl];
        
        _cancelBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, viewBG.bounds.origin.y+100, 150, 50)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.layer.borderWidth =1;
        _cancelBtn.layer.borderColor =GRAY_COLOR.CGColor;
        [_cancelBtn addTarget:self action:@selector(cancelBtn) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitleColor:GRAY_COLOR forState:UIControlStateNormal];
        [viewBG addSubview:_cancelBtn];
        
        _sureBtn =[[UIButton alloc]initWithFrame:CGRectMake(150, viewBG.bounds.origin.y+100, 150, 50)];
        [_sureBtn setTitle:@"绑定" forState:UIControlStateNormal];
        [_sureBtn  setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _sureBtn.layer.borderWidth =1;
        [_sureBtn addTarget:self action:@selector(surebtn) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.layer.borderColor =GRAY_COLOR.CGColor;
        [viewBG addSubview:_sureBtn];
        
        
        
        
        
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

#pragma mark - saomaoMethod



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
