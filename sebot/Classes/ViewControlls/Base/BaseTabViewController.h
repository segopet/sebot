//
//  BaseTabViewController.h
//  sebot
//
//  Created by yulei on 16/6/16.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTabViewController : BaseViewController

@property (nonatomic, strong) UITableView* tableView;
//资源数组
@property (nonatomic, strong) NSMutableArray* dataSource;
@property (nonatomic,strong)NSMutableArray * dicSource;
@property (nonatomic, assign) BOOL bGroupView;

@end
