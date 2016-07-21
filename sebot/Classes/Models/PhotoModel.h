//
//  PhotoModel.h
//  sebot
//
//  Created by yulei on 16/7/20.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseJSONModel.h"
@interface PhotoModel : BaseJSONModel

@property (nonatomic,copy)NSString * aid;
@property (nonatomic,copy)NSString * albumname;
@property (nonatomic,copy)NSString * createtime;
@property (nonatomic,copy)NSString * networkaddress;
@property (nonatomic,copy)NSString * photoname;
@property (nonatomic,copy)NSString * pid;


@end
