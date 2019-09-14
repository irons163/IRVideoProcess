//
//  IRVPMessageLoop.m
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import "IRVPMessageLoop.h"
#import "IRVPObjectQueue.h"

@interface IRVPMessageLoop ()

@property (nonatomic, strong) NSThread * thread;
@property (nonatomic, strong) IRVPObjectQueue * messageQueue;
@property (nonatomic, assign) BOOL didClosed;

@end

@implementation IRVPMessageLoop

- (instancetype)init
{
    if (self = [super init])
    {
        self.messageQueue = [[IRVPObjectQueue alloc] init];
        self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(messageLoopThread) object:nil];
        self.thread.qualityOfService = NSQualityOfServiceDefault;
        self.thread.name = @"KTVVPMessageLoop-thread";
    }
    return self;
}

- (void)run
{
    [self.thread start];
}

- (void)stop
{
    self.didClosed = YES;
}

- (void)putMessage:(IRVPMessage *)message
{
    [self.messageQueue putObject:message];
}

- (void)messageLoopThread
{
    while (YES)
    {
        if (self.didClosed)
        {
            break;
        }
        IRVPMessage * message = [self.messageQueue getObjectSync];
        if (!message)
        {
            continue;
        }
        [self.delegate messageLoop:self processingMessage:message];
    }
}

@end
