//
//  BaseModel.h
//  petegg
//
//  Created by ldp on 16/3/23.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "BaseJSONModel.h"

@interface ResponseModel : BaseJSONModel

@property (nonatomic, strong) NSDictionary *retVal;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *retDesc;

@property (nonatomic, copy) NSString *retCode;

@property (nonatomic, strong) NSArray *list;

+ (instancetype)modelWithDictionary: (NSDictionary *) data;

@end
