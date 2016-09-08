//
//  PhotoCollectionViewCell.h
//  sebot
//
//  Created by yulei on 16/7/20.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ImageHeader;
@property (strong, nonatomic) IBOutlet UILabel *PhotoName;
@property (strong, nonatomic) IBOutlet UILabel *PhotoNumber;
@property (strong, nonatomic) IBOutlet UIImageView *downImageV;

@property (nonatomic,strong)UIView * whiteView;
@property (nonatomic,strong)UIImageView * firstImage;
@property (nonatomic,strong)UILabel * firstLabel;


@end
