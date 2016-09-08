//
//  PhotoCollectionViewCell.m
//  sebot
//
//  Created by yulei on 16/7/20.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"PhotoCollectionViewCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
        
        _whiteView = [[UIView alloc]initWithFrame:self.frame];
        _whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_whiteView];
        
        
        _firstImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.frame) + 30, CGRectGetMinY(self.frame) + 20, 50 * W_Wide_Zoom, 50 * W_Hight_Zoom)];
        _firstImage.image = [UIImage imageNamed:@"addphoto.png"];
        [self addSubview:_firstImage];
        
        _firstLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.frame) + 30, CGRectGetMaxY(_firstImage.frame) + 5 ,200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        //newAlubmLabel.backgroundColor = [UIColor blackColor];
        _firstLabel.text = @"新建相册";
        _firstLabel.textColor = [UIColor blackColor];
        _firstLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_firstLabel];
        

        
        
        
        
    }
    
    return self;
    
}
@end
