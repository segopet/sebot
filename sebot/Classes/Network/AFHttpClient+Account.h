//
//  AFHttpClient+Account.h
//  petegg
//
//  Created by ldp on 16/4/5.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (Account)



- (void)loginWithUserName:(NSString*)userName password:(NSString*)password userid:(NSString *)userid  complete:(void(^)(ResponseModel *model))completeBlock;




@end
