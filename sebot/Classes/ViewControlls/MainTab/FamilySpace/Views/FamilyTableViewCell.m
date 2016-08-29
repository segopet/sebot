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
        _bigImage.backgroundColor =[UIColor clearColor];
        _bigImage.layer.masksToBounds = YES;
        _bigImage.contentMode = UIViewContentModeCenter;
        [self addSubview:_bigImage];
        
        _headImage= [[UIImageView alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 17 * W_Hight_Zoom,40 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
        _headImage.backgroundColor = [UIColor clearColor];
        _headImage.layer.cornerRadius = _headImage.width/2;
        [self addSubview:_headImage];
        
        _namelabel = [[UILabel alloc]initWithFrame:CGRectMake(55 * W_Wide_Zoom, 25 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        _namelabel.text = @"Tony";
        _namelabel.font = [UIFont systemFontOfSize:14];
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
        
        _aixin = [[UIButton alloc]initWithFrame:CGRectMake(250 * W_Wide_Zoom, 380 * W_Hight_Zoom, 16 * W_Wide_Zoom, 15 * W_Hight_Zoom)];
        [_aixin setImage:[UIImage imageNamed:@"dianzanzan.png"] forState:UIControlStateNormal];
        [_aixin setImage:[UIImage imageNamed:@"dianzanhou.png"] forState:UIControlStateSelected];

        [self addSubview:_aixin];
        
        _aixinLabel = [[UILabel alloc]initWithFrame:CGRectMake(280 * W_Wide_Zoom, 373 * W_Hight_Zoom , 50 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        _aixinLabel.font = [UIFont systemFontOfSize:14];
        _aixinLabel.textColor = [UIColor lightGrayColor];
        _aixinLabel.text = @"12";
        [self addSubview:_aixinLabel];
        
        _pinglun = [[UIButton alloc]initWithFrame:CGRectMake(310 * W_Wide_Zoom, 380 * W_Hight_Zoom, 16 * W_Wide_Zoom, 15 * W_Hight_Zoom)];
        [_pinglun setImage:[UIImage imageNamed:@"pinglunlun.png"] forState:UIControlStateNormal];
        [self addSubview:_pinglun];
        
        _pinglunlabel = [[UILabel alloc]initWithFrame:CGRectMake(340 * W_Wide_Zoom, 373 * W_Hight_Zoom, 50 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        
        _pinglunlabel.textColor = [UIColor lightGrayColor];
        _pinglunlabel.font = [UIFont systemFontOfSize:14];
        _pinglunlabel.text = @"22";
        [self addSubview:_pinglunlabel];
        
        _pinglunBtn = [[UIButton alloc]initWithFrame:CGRectMake(310 * W_Wide_Zoom, 370 * W_Hight_Zoom, 60 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        _pinglunBtn.backgroundColor = [UIColor clearColor];
        [self addSubview:_pinglunBtn];
        
        
        
        
        
        
        
        
    }



    return self;
}


@end
