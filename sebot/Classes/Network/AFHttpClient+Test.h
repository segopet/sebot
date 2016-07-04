//
//  AFHttpClient+Test.h
//  sebot
//
//  Created by czx on 16/7/4.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (Test)
-(void)testWithuserid:(NSString *)userid token:(NSString *)token complete:(void(^)(BaseModel *model))completeBlock;




@end
