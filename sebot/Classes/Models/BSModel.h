//
//  BSModel.h
//  sebot
//
//  Created by czx on 16/7/1.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "JSONModel.h"

@interface BSModel : JSONModel
+ (instancetype)modelWithDictionary: (NSDictionary *) data;
@end
