//
//  IRVPObjectQueue.m
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import "IRVPObjectQueue.h"

@interface IRVPObjectQueue ()

@property (nonatomic, strong) NSCondition * condition;
@property (nonatomic, strong) NSMutableArray * objects;
@property (nonatomic, assign) BOOL didDestoryed;

@end

@implementation IRVPObjectQueue

- (instancetype)init
{
    if (self = [super init])
    {
        self.condition = [[NSCondition alloc] init];
        self.objects = [NSMutableArray array];
    }
    return self;
}

- (void)putObject:(id)object
{
    [self.condition lock];
    [self.objects addObject:object];
    [self.condition signal];
    [self.condition unlock];
}

- (id)getObjectSync
{
    [self.condition lock];
    while (self.objects.count <= 0)
    {
        [self.condition wait];
        if (self.didDestoryed)
        {
            [self.condition unlock];
            return nil;
        }
    }
    id object = self.objects.firstObject;
    [self.objects removeObjectAtIndex:0];
    [self.condition signal];
    [self.condition unlock];
    return object;
}

- (void)destory
{
    self.didDestoryed = YES;
}

@end
