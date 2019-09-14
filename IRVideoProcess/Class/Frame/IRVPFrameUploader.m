//
//  IRVPFrameUploader.m
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import "IRVPFrameUploader.h"

@interface IRVPFrameUploader ()

@property (nonatomic, strong) EAGLContext * glContext;
@property (nonatomic, assign) CVOpenGLESTextureCacheRef glTextureCache;

@end

@implementation IRVPFrameUploader

- (instancetype)initWithGLContext:(EAGLContext *)glContext
{
    if (self = [super init])
    {
        self.glContext = glContext;
    }
    return self;
}

- (CVOpenGLESTextureCacheRef)glTextureCache
{
    if (!_glTextureCache)
    {
        CVReturn error = CVOpenGLESTextureCacheCreate(kCFAllocatorDefault, NULL, self.glContext, NULL, &_glTextureCache);
        if (error)
        {
            NSLog(@"KTVVPFrameUploader failed to create OpenGL texture cache.");
        }
    }
    return _glTextureCache;
}

- (void)dealloc
{
    if (_glTextureCache)
    {
        CVOpenGLESTextureCacheFlush(_glTextureCache, 0);
        CFRelease(_glTextureCache);
        _glTextureCache = NULL;
    }
}

@end
