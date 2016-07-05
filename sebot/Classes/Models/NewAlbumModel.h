//
//  NewAlbumModel.h
//  sebot
//
//  Created by czx on 16/6/29.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <MojoDatabase/MojoDatabase.h>
//相册列表model
@interface NewAlbumModel : JSONModel
+ (instancetype)modelWithDictionary: (NSDictionary *) data;
@property (nonatomic,strong)NSString * aid;
@property (nonatomic,strong)NSString * albumname;
@property (nonatomic,strong)NSString * cover;
@property (nonatomic,strong)NSString * did;
@property (nonatomic,strong)NSString * photonum;
@property (nonatomic,strong)NSString * userid;



@end
