//
//  ImageModel.h
//  sebot
//
//  Created by yulei on 16/7/21.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseJSONModel.h"
@interface ImageModel : BaseJSONModel

@property (nonatomic,copy)NSString *imagename;
@property (nonatomic,copy)NSString * networkaddress;
@end
