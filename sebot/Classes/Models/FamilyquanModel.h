//
//  FamilyquanModel.h
//  sebot
//
//  Created by czx on 16/7/14.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "BaseJSONModel.h"

@interface FamilyquanModel : BaseJSONModel
@property (nonatomic,copy)NSString * accountnumber;
@property (nonatomic,copy)NSString * aid;
@property (nonatomic,copy)NSString * comments;
@property (nonatomic,copy)NSString * content;
@property (nonatomic,copy)NSString * headportrait;
@property (nonatomic,copy)NSString * nickname;
@property (nonatomic,copy)NSString * photonum;
@property (nonatomic,copy)NSString * pid;
@property (nonatomic,copy)NSString * praised;
@property (nonatomic,copy)NSString * praises;
@property (nonatomic,copy)NSString * publishtime;
@property (nonatomic,copy)NSString * reports;
@property (nonatomic,copy)NSString * status;
@property (nonatomic,copy)NSString * thumbnails;
@property (nonatomic,copy)NSString * type;
@property (nonatomic,copy)NSString * userid;
@property (nonatomic,strong)UIImage * cutImage;
@end
