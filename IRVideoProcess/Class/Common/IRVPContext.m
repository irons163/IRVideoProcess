//
//  IRVPContext.m
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import "IRVPContext.h"

@implementation IRVPContext

- (instancetype)init
{
    if (self = [super init])
    {
        _mainGLContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    }
    return self;
}

- (void)dealloc
{
    _mainGLContext = nil;
}

@end
