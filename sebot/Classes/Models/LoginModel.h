//
//  LoginModel.h
//  sebot
//
//  Created by czx on 16/6/21.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <MojoDatabase/MojoDatabase.h>

@interface LoginModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *accountnumber;
@property (nonatomic, copy) NSString<Optional> *channelid;
@property (nonatomic, copy) NSString<Optional> *headportrait;
@property (nonatomic, copy) NSString<Optional> *nickname;
@property (nonatomic, copy) NSString<Optional> *nowcity;
@property (nonatomic, copy) NSString<Optional> *password;
@property (nonatomic, copy) NSString<Optional> *phone;
@property (nonatomic, copy) NSString<Optional> *registertime;
@property (nonatomic, copy) NSString<Optional> *sipno;
@property (nonatomic, copy) NSString<Optional> *sippw;
@property (nonatomic, copy) NSString<Optional> *userid;
+ (instancetype)modelWithDictionary: (NSDictionary *) data;
@end
