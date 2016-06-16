//
//  PromptboxView.h
//  sebot
//
//  Created by yulei on 16/6/16.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromptboxView : UIView

{
    UILabel         *_textLabel;
    int             _queueCount;
    
}
@property (strong)UIView *ParentView;

- (void) setText:(NSString *) text;
@end
