//
//  PersonModel.h
//  sebot
//
//  Created by yulei on 16/6/30.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : BaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@property (nonatomic,copy)NSString *activationtime;//
@property (nonatomic,copy)NSString *channelid;
@property (nonatomic,copy)NSString *headportrait;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *nowcity;
@property (nonatomic,copy)NSString *password;
@property (nonatomic,copy)NSString * phone;
@property (nonatomic,copy)NSString * registertime;
@property (nonatomic,copy)NSString * sipno;
@property (nonatomic,copy)NSString * sippw;
@property (nonatomic,copy)NSString * userid;

@end
