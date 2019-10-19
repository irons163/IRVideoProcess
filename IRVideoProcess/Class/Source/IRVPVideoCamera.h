//
//  IRVPVideoCamera.h
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRVPOutput.h"
#import "IRVPContext.h"

NS_ASSUME_NONNULL_BEGIN

@interface IRVPVideoCamera : NSObject <IRVPOutput>

- (instancetype)initWithContext:(IRVPContext *)context;

@property (nonatomic, strong, readonly) IRVPContext * context;

- (void)startRunning;

@end

NS_ASSUME_NONNULL_END
