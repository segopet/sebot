//
//  ShowPhotoViewController.h
//  sebot
//
//  Created by yulei on 16/7/21.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "BaseViewController.h"
#import "QFTableView.h"
#import "ImageModel.h"
@interface ShowPhotoViewController : BaseViewController<QFTableViewDataSource,QFTableViewDelegate>
@property (nonatomic,strong)ImageModel * model;

@end
