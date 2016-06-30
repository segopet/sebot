//
//  NewAlumbleTableViewCell.m
//  sebot
//
//  Created by czx on 16/6/23.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "NewAlumbleTableViewCell.h"

@implementation NewAlumbleTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _linleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 * W_Wide_Zoom, 0 * W_Hight_Zoom, 365 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        _linleLabel.backgroundColor = GRAY_COLOR;
        [self addSubview:_linleLabel];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 * W_Wide_Zoom, 15 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        _nameLabel.text = @"全选:";
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_nameLabel];
        
        
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(350 * W_Wide_Zoom, 20 * W_Hight_Zoom, 20 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
        _rightBtn.layer.cornerRadius = _rightBtn.width/2;
        //_rightBtn.backgroundColor = [UIColor blueColor];
        [_rightBtn setImage:[UIImage imageNamed:@"baiquan.png"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"gouquan.png"] forState:UIControlStateSelected];
        [self addSubview:_rightBtn];
        
        
        
        
    }

    return self;

}
@end
