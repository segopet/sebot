//
//  LoginModel.h
//  sebot
//
//  Created by czx on 16/6/21.
//  Copyright © 2016年 sego. All rights reserved.
//

//#import <MojoDatabase/MojoDatabase.h>
#import <Foundation/Foundation.h>

@interface LoginModel : BaseJSONModel
+ (instancetype)modelWithDictionary: (NSDictionary *) data;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@property (nonatomic, copy) NSString * accountnumber;
@property (nonatomic, copy) NSString * channelid;
@property (nonatomic, copy) NSString * headportrait;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * nowcity;
@property (nonatomic, copy) NSString * password;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * registertime;
@property (nonatomic, copy) NSString * sipno;
@property (nonatomic, copy) NSString * sippw;
@property (nonatomic, copy) NSString * userid;

@end
