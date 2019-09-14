//
//  IRVPMessage.m
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import "IRVPMessage.h"

@implementation IRVPMessage

+ (instancetype)messageWithType:(NSUInteger)type object:(id)object
{
    return [[self alloc] initWithType:type object:object];
}

- (instancetype)initWithType:(NSUInteger)type object:(id)object
{
    if (self = [super init])
    {
        self.type = type;
        self.object = object;
    }
    return self;
}

@end
