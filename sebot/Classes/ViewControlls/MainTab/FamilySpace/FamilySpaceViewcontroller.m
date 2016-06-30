//
//  FamilySpaceViewcontroller.m
//  sebot
//
//  Created by yulei on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "FamilySpaceViewcontroller.h"
#import "NewPhotoalbumViewController.h"


@implementation FamilySpaceViewcontroller


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"tabFamily", nil)];
     self.view.backgroundColor = [UIColor whiteColor];
    [self showBarButton:NAV_RIGHT title:NSLocalizedString(@"navUpdateimage", nil) fontColor:[UIColor redColor]];
    
    
    
}



-(void)doRightButtonTouch{ 
    NewPhotoalbumViewController * newVc = [[NewPhotoalbumViewController alloc]init];
    [self.navigationController pushViewController:newVc animated:NO];


}




@end
