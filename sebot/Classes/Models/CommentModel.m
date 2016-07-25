//
//  CommentModel.m
//  sebot
//
//  Created by czx on 16/7/20.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
- (instancetype)init{
    if (self = [super init]) {
        self.list = [NSMutableArray array];
    }
    return self;
}
@end
