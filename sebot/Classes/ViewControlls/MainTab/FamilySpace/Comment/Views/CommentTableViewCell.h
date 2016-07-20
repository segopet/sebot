//
//  CommentTableViewCell.h
//  sebot
//
//  Created by czx on 16/7/20.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView * headImage;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UILabel * contentLabel;
@property (nonatomic,strong)UILabel * timelabel;
@property (nonatomic,strong)UILabel * lineLabel;

@property (nonatomic,strong)UILabel * firstname;
@property (nonatomic,strong)UILabel * huifuLabel;
@property (nonatomic,strong)UILabel * lastName;
@property (nonatomic,strong)UILabel * lastContentlabel;


@end
