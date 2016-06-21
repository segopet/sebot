//
//  ForegetPasswordViewController.m
//  sebot
//
//  Created by czx on 16/6/17.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "ForegetPasswordViewController.h"

@interface ForegetPasswordViewController ()

@end

@implementation ForegetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = NEW_GRAY_COLOR;
    [self setNavTitle:@"忘记密码"];
    [UINavigationBar appearance].barTintColor=RED_COLOR;
    [self initUserface];
}
-(void)initUserface{
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 68 * W_Hight_Zoom, 375 * W_Wide_Zoom, 200 * W_Hight_Zoom)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    NSArray * namearray = @[NSLocalizedString(@"phoneNumber", nil),NSLocalizedString(@"yanzhengma", nil),NSLocalizedString(@"password", nil),NSLocalizedString(@"surePassword", nil)];
    for (int i = 0 ; i < 4 ; i++ ) {
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 50 * W_Hight_Zoom + i * 50 * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        lineLabel.backgroundColor = GRAY_COLOR;
        [topView addSubview:lineLabel];
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 15 * W_Hight_Zoom + i * 50 * W_Hight_Zoom, 80 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
        nameLabel.text = namearray[i];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.textAlignment = NSTextAlignmentRight;
        nameLabel.font = [UIFont systemFontOfSize:14];
        [topView addSubview:nameLabel];
    }
    
    
    
    
    
    

}
@end