//
//  AFHttpClient+Videomessage.h
//  sebot
//
//  Created by czx on 16/8/22.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (Videomessage)
-(void)getVideomessageWithUserid:(NSString *)userid token:(NSString *)token page:(NSString *)page complete:(void(^)(ResponseModel *model))completeBlock;


@end
