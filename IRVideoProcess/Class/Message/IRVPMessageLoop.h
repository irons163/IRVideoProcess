//
//  IRVPMessageLoop.h
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRVPMessage.h"

NS_ASSUME_NONNULL_BEGIN

@class IRVPMessageLoop;

@protocol IRVPMessageLoopDelegate <NSObject>

- (void)messageLoop:(IRVPMessageLoop *)messageLoop processingMessage:(IRVPMessage *)message;

@end

@interface IRVPMessageLoop : NSObject

@property (nonatomic, weak) id <IRVPMessageLoopDelegate> delegate;
@property (nonatomic, strong, readonly) NSThread * thread;

- (void)run;
- (void)stop;

- (void)putMessage:(IRVPMessage *)message;

@end


NS_ASSUME_NONNULL_END
