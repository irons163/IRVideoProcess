//
//  IRVPOutput.h
//  IRVideoProcess
//
//  Created by irons on 2019/10/19.
//  Copyright © 2019年 irons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRVPFrame.h"
#import "IRVPInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IRVPOutput <NSObject>

- (void)addInput:(id <IRVPInput>)input;
- (void)removeInput:(id <IRVPInput>)input;

@end

NS_ASSUME_NONNULL_END
