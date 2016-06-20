//
//  OpinionViewController.m
//  sebot
//
//  Created by yulei on 16/6/20.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "OpinionViewController.h"

@interface OpinionViewController ()

@end

@implementation OpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"Opinion", nil)];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
