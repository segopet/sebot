//
//  FamilyTeamTableViewCell.h
//  sebot
//
//  Created by yulei on 16/6/17.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyTeamTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *moveBtn;

@property (strong, nonatomic) IBOutlet UILabel *conterLable;
@property (strong, nonatomic) IBOutlet UIButton *transferBtn;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@end
