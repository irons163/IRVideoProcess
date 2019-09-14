//
//  IRVPFrame.m
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import "IRVPFrame.h"

@interface IRVPFrame ()

@property (nonatomic, assign) BOOL didUpload;

@property (nonatomic, assign) CVOpenGLESTextureRef glRGBATexture;

@end

@implementation IRVPFrame

+ (IRVPGLTextureOptions)textureOptions
{
    static IRVPGLTextureOptions textureOptions;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        textureOptions.minFilter = GL_LINEAR;
        textureOptions.magFilter = GL_LINEAR;
        textureOptions.wrapS = GL_CLAMP_TO_EDGE;
        textureOptions.wrapT = GL_CLAMP_TO_EDGE;
        textureOptions.internalFormat = GL_RGBA;
        textureOptions.format = GL_BGRA;
        textureOptions.type = GL_UNSIGNED_BYTE;
    });
    return textureOptions;
}

- (instancetype)initWithTextureRef:(GLuint)texture
{
    if (self = [super init])
    {
        _type = IRVPFrameTypeTextureRef;
        _texture = texture;
        _didUpload = YES;
    }
    return self;
}

- (instancetype)initWithTextureOptions:(IRVPGLTextureOptions)textureOptions
{
    if (self = [super init])
    {
        _type = IRVPFrameTypeTextureOnly;
        _textureOptions = textureOptions;
    }
    return self;
}

- (instancetype)initWithFramebufferSize:(IRVPGLSize)framebufferSize
{
    return [self initWithFramebufferSize:framebufferSize
                          textureOptions:[IRVPFrame textureOptions]];
}

- (instancetype)initWithFramebufferSize:(IRVPGLSize)framebufferSize
                         textureOptions:(IRVPGLTextureOptions)textureOptions
{
    if (self = [super init])
    {
        _type = IRVPFrameTypeDrawable;
        _textureOptions = textureOptions;
        _framebufferSize = framebufferSize;
    }
    return self;
}

- (instancetype)initWithCMSmapleBuffer:(CMSampleBufferRef)sampleBuffer
{
    return [self initWithCMSmapleBuffer:sampleBuffer
                         textureOptions:[IRVPFrame textureOptions]];
}

- (instancetype)initWithCMSmapleBuffer:(CMSampleBufferRef)sampleBuffer
                        textureOptions:(IRVPGLTextureOptions)textureOptions
{
    if (self = [super init])
    {
        _type = IRVPFrameTypeCMSampleBuffer;
        _textureOptions = textureOptions;
        _sampleBuffer = sampleBuffer;
        if (_sampleBuffer)
        {
            CFRetain(_sampleBuffer);
        }
    }
    return self;
}

- (instancetype)initWithCVPixelBuffer:(CVPixelBufferRef)pixelBuffer
{
    return [self initWithCVPixelBuffer:pixelBuffer
                        textureOptions:[IRVPFrame textureOptions]];
}

- (instancetype)initWithCVPixelBuffer:(CVPixelBufferRef)pixelBuffer
                       textureOptions:(IRVPGLTextureOptions)textureOptions
{
    if (self = [super init])
    {
        _type = IRVPFrameTypeCVPixelBuffer;
        _textureOptions = textureOptions;
        _pixelBuffer = pixelBuffer;
        if (_pixelBuffer)
        {
            CFRetain(_pixelBuffer);
        }
    }
    return self;
}

- (void)dealloc
{
    switch (_type)
    {
        case IRVPFrameTypeTextureRef:
        {
            
        }
            break;
        case IRVPFrameTypeTextureOnly:
        {
            
        }
            break;
        case IRVPFrameTypeDrawable:
        {
            
        }
            break;
        case IRVPFrameTypeCMSampleBuffer:
        {
            if (_sampleBuffer)
            {
                CFRelease(_sampleBuffer);
                _sampleBuffer = NULL;
            }
            if (_glRGBATexture)
            {
                CFRelease(_glRGBATexture);
                _glRGBATexture = NULL;
            }
        }
            break;
        case IRVPFrameTypeCVPixelBuffer:
        {
            if (_pixelBuffer)
            {
                CFRelease(_pixelBuffer);
                _pixelBuffer = NULL;
            }
        }
            break;
    }
}

- (void)uploadIfNeed:(IRVPFrameUploader *)uploader
{
    if (self.didUpload)
    {
        return;
    }
    switch (_type)
    {
        case IRVPFrameTypeTextureRef:
            break;
        case IRVPFrameTypeTextureOnly:
        {
            glGenTextures(1, &_texture);
            glBindTexture(GL_TEXTURE_2D, _texture);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, _textureOptions.minFilter);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, _textureOptions.magFilter);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, _textureOptions.wrapS);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, _textureOptions.wrapT);
            
            self.didUpload = YES;
        }
            break;
        case IRVPFrameTypeDrawable:
        {
            
        }
            break;
        case IRVPFrameTypeCMSampleBuffer:
        {
            CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(_sampleBuffer);
            
            int width = (int)CVPixelBufferGetWidth(pixelBuffer);
            int height = (int)CVPixelBufferGetHeight(pixelBuffer);
            
            CVPixelBufferLockBaseAddress(pixelBuffer, 0);
            CVReturn error;
            error = CVOpenGLESTextureCacheCreateTextureFromImage(kCFAllocatorDefault,
                                                                 uploader.glTextureCache,
                                                                 pixelBuffer,
                                                                 NULL,
                                                                 GL_TEXTURE_2D,
                                                                 GL_RGBA,
                                                                 width,
                                                                 height,
                                                                 GL_BGRA,
                                                                 GL_UNSIGNED_BYTE,
                                                                 0,
                                                                 &_glRGBATexture);
            if (error)
            {
                NSLog(@"Error at CVOpenGLESTextureCacheCreateTextureFromImage %d", error);
            }
            
            _texture = CVOpenGLESTextureGetName(_glRGBATexture);
            glBindTexture(GL_TEXTURE_2D, _texture);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, _textureOptions.minFilter);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, _textureOptions.magFilter);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, _textureOptions.wrapS);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, _textureOptions.wrapT);
            
            CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
            
            self.didUpload = YES;
        }
            break;
        case IRVPFrameTypeCVPixelBuffer:
        {
            
        }
            break;
    }
}

- (void)lock
{
    
}

- (void)unlock
{
    
}

@end
