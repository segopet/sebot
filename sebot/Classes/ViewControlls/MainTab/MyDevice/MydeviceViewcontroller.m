//
//  MydeviceViewcontroller.m
//  sebot
//
//  Created by yulei on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "MydeviceViewcontroller.h"
#import "PromptboxView.h"

@interface MydeviceViewcontroller()
{
    
    
    PromptboxView * popView;
    
}

@end


@implementation MydeviceViewcontroller


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"tabDevice", nil)];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    [self showBarButton:NAV_RIGHT imageName:@"tab_square_press"];
    
    
    [self initAlertView];
    
    
    
    
    
}


//初始化弹出框

- (void)initAlertView
{
    
    
    UIView * viewCenter =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 260, 150)];
    viewCenter.hidden = NO;
    viewCenter.center = self.view.center;
    viewCenter.layer.borderColor =GRAY_COLOR.CGColor;
    viewCenter.layer.borderWidth = 1;
    [self.view addSubview:viewCenter];
    
    UILabel * handLable =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 260, 30)];
    handLable.textAlignment = NSTextAlignmentCenter;
    handLable.text =@"添加设备";
    handLable.textColor =[UIColor redColor];
    [viewCenter addSubview:handLable];
    
    UILabel * numberLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 30, 60, 30)];
    numberLabel.text =@"设备号:";
    numberLabel.textColor =[UIColor redColor];
    [viewCenter addSubview:numberLabel];
    
    UITextField * numberTextFild =[[UITextField alloc]initWithFrame:CGRectMake(60, 30, 100, 30)];
    numberTextFild.text =@"123244";
    [viewCenter addSubview:numberTextFild];
    
    
    UIButton * SaomaBtn =[[UIButton alloc]initWithFrame:CGRectMake(170, 30, 30, 30)];
    
    [SaomaBtn setImage:[UIImage imageNamed:@"tab_square_normal"] forState:UIControlStateNormal];
    [SaomaBtn addTarget:self action:@selector(saomao) forControlEvents:UIControlEventTouchUpInside];
    
    [viewCenter addSubview:SaomaBtn];
    
    
    
    
    
}
// 扫描
- (void)saomao
{
    
    
}



// 添加
- (void)doRightButtonTouch
{
    
    
}


@end
