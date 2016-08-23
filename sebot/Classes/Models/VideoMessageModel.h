//
//  VideoMessageModel.h
//  sebot
//
//  Created by czx on 16/8/22.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "BaseJSONModel.h"

@interface VideoMessageModel : BaseJSONModel
@property (nonatomic,copy)NSString * deviceremark;
@property (nonatomic,copy)NSString * networkaddress;
@property (nonatomic,copy)NSString * opttime;
@property (nonatomic,copy)NSString * receiver;
@property (nonatomic,copy)NSString * sender;
@property (nonatomic,copy)NSString * thumbnails;
@property (nonatomic,copy)NSString * vmid;

@property (nonatomic,strong)UIImage * cutImage;


@end
