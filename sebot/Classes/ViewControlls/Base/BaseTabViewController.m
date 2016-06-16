//
//  BaseTabViewController.m
//  sebot
//
//  Created by yulei on 16/6/16.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "BaseTabViewController.h"

@interface BaseTabViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)setupData{
    _dataSource = [NSMutableArray array];
    
}

- (void)setupView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.bGroupView ? UITableViewStyleGrouped : UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = LIGHT_GRAY_COLOR;
    
    [self.view addSubview:_tableView];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
