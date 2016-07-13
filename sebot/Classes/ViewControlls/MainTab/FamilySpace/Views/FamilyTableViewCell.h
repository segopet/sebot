//
//  FamilyTableViewCell.h
//  sebot
//
//  Created by czx on 16/7/7.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyTableViewCell : UITableViewCell
@property (nonatomic,strong)UIView * topView;
@property (nonatomic,strong)UIImageView * headImage;
@property (nonatomic,strong)UILabel * namelabel;
@property (nonatomic,strong)UILabel * numberLabel;
@property (nonatomic,strong)UIImageView * bigImage;
@property (nonatomic,strong)UILabel * content;
@property (nonatomic,strong)UILabel * lineLabel;
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UIButton * aixin;
@property (nonatomic,strong)UILabel * aixinLabel;
@property (nonatomic,strong)UIImageView * pinglun;
@property (nonatomic,strong)UILabel * pinglunlabel;



@end
