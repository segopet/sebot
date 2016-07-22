//
//  CommentTableViewCell.m
//  sebot
//
//  Created by czx on 16/7/20.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 375 *W_Wide_Zoom, 1 * W_Hight_Zoom)];
        _lineLabel.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_lineLabel];
        
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10 * W_Wide_Zoom, 20 * W_Hight_Zoom, 50 * W_Wide_Zoom, 50 * W_Hight_Zoom)];
        _headImage.layer.cornerRadius = _headImage.width/2;
        _headImage.backgroundColor = [UIColor blackColor];
        [self addSubview:_headImage];
        
       // _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70 * W_Wide_Zoom, 20 * W_Hight_Zoom, 0 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = RED_COLOR;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_nameLabel];
        
        
      //  _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame) + 5 * W_Wide_Zoom, 20 * W_Hight_Zoom, 0 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_contentLabel];
        
        
        _timelabel = [[UILabel alloc]init];
        _timelabel.textColor = [UIColor lightGrayColor];
        _timelabel.font = [UIFont systemFontOfSize:14];
        _timelabel.text = @"2016/15/13 17:43:12";
        [self addSubview:_timelabel];
        
        
        
        //@property (nonatomic,strong)UILabel * firstname;
        //@property (nonatomic,strong)UILabel * huifuLabel;
        //@property (nonatomic,strong)UILabel * lastName;
        //@property (nonatomic,strong)UILabel * lastContentlabel;
      //  _firstname = [[UILabel alloc]init];
//        _huifuLabel = [[UILabel alloc]init];
//        _lastName = [[UILabel alloc]init];
//        _lastContentlabel = [[UILabel alloc]init];
        
       
    }




    return  self;
}






@end
