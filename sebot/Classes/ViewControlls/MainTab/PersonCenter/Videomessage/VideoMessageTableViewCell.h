//
//  VideoMessageTableViewCell.h
//  sebot
//
//  Created by czx on 16/8/18.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoMessageTableViewCell : UITableViewCell
@property (nonatomic,strong)UIView * topView;
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UIImageView * centerImage;
@property (nonatomic,strong)UIImageView * leftdownImage;
@property (nonatomic,strong)UILabel * nameLabel;


@end
