//
//  CommentModel.h
//  sebot
//
//  Created by czx on 16/7/20.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "BaseJSONModel.h"
@protocol CommentModel
@end
@interface CommentModel : BaseJSONModel
@property (nonatomic, copy) NSString * action;
@property (nonatomic, copy) NSString * bcid;
@property (nonatomic, copy) NSString * bname;
@property (nonatomic, copy) NSString * cid;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * headportrait;
@property (nonatomic, strong) NSMutableArray<CommentModel,Optional> *list;
@property (nonatomic, copy) NSString * opttime;
@property (nonatomic, copy) NSString * pid;
@property (nonatomic, copy) NSString * ptype;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * username;
@property (nonatomic, copy) NSString * wid;









@end