//
//  VideoMessageTableViewCell.m
//  sebot
//
//  Created by czx on 16/8/18.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "VideoMessageTableViewCell.h"

@implementation VideoMessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 5 * W_Hight_Zoom)];
        _topView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_topView];
        
        _centerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 7 * W_Hight_Zoom, 375 * W_Wide_Zoom, 195 * W_Hight_Zoom)];
        _centerImage.layer.masksToBounds = YES;
        _centerImage.contentMode = UIViewContentModeCenter;
        _centerImage.backgroundColor = [UIColor blackColor];
        [self addSubview:_centerImage];
        

        UIImageView * mengceng = [[UIImageView alloc]initWithFrame:_centerImage.frame];
        mengceng.image = [UIImage imageNamed:@"mengcengceng.png"];
        [self addSubview:mengceng];
        
        
        
        UILabel * fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(7 * W_Wide_Zoom, 15 * W_Hight_Zoom, 50 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        fromLabel.text = @"From:";
        fromLabel.textColor = [UIColor whiteColor];
        fromLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:fromLabel];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60 * W_Wide_Zoom, 15 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        _nameLabel.text = @"赛果";
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_nameLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(230 * W_Wide_Zoom, 17 * W_Hight_Zoom, 150 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_timeLabel];
        
        
        _leftdownImage = [[UIImageView alloc]initWithFrame:CGRectMake(7 * W_Wide_Zoom, 157 * W_Hight_Zoom, 35 * W_Wide_Zoom, 35 * W_Hight_Zoom)];
        _leftdownImage.image = [UIImage imageNamed:@"playplay.png"];
        [self addSubview:_leftdownImage];
        
       
        
        
        
    }

    return  self;
}



@end
