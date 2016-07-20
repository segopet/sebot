//
//  NewAlbumAdviceModel.h
//  sebot
//
//  Created by czx on 16/6/30.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <Foundation/Foundation.h>

//新建相册里面设备列表
@interface NewAlbumAdviceModel : BaseJSONModel
@property (nonatomic,copy)NSString * aid;
@property (nonatomic,copy)NSString * albumname;
@property (nonatomic,copy)NSString * chose;
@property (nonatomic,copy)NSString * deviceremark;
@property (nonatomic,copy)NSString * did;


@end
