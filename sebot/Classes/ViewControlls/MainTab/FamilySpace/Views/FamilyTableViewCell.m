//
//  FamilyTableViewCell.m
//  sebot
//
//  Created by czx on 16/7/7.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "FamilyTableViewCell.h"

@implementation FamilyTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 8 * W_Hight_Zoom)];
        _topView.backgroundColor = [UIColor lightGrayColor];
        _topView.alpha = 0.1;
        [self addSubview:_topView];
            
        _bigImage = [[UIImageView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 65 * W_Hight_Zoom, 375 * W_Wide_Zoom, 270 * W_Hight_Zoom)];
        _bigImage.backgroundColor =[UIColor blueColor];
        [self addSubview:_bigImage];
        
        _headImage= [[UIImageView alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 17 * W_Hight_Zoom,40 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
        _headImage.backgroundColor = [UIColor blackColor];
        _headImage.layer.cornerRadius = _headImage.width/2;
        [self addSubview:_headImage];
        
        _namelabel = [[UILabel alloc]initWithFrame:CGRectMake(55 * W_Wide_Zoom, 25 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        _namelabel.text = @"Tony";
        _namelabel.textColor = [UIColor blackColor];
        [self addSubview:_namelabel];
        
        _content = [[UILabel alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 337 * W_Hight_Zoom, 300 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        _content.text = @"和朋友们相聚";
        _content.textColor = [UIColor blackColor];
        _content.font = [UIFont systemFontOfSize:14];
        [self addSubview:_content];
        
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 367 * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        _lineLabel.backgroundColor = LIGHT_GRAY_COLOR;
        [self addSubview:_lineLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 372 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        _timeLabel.text = @"2015-09-12 18:11";
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_timeLabel];
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }



    return self;
}


@end
