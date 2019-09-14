//
//  IRVPFrame.h
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "IRVPGLDefines.h"
#import "IRVPFrameUploader.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, IRVPFrameType)
{
    IRVPFrameTypeTextureRef,
    IRVPFrameTypeTextureOnly,
    IRVPFrameTypeDrawable,
    IRVPFrameTypeCMSampleBuffer,
    IRVPFrameTypeCVPixelBuffer,
};


@interface IRVPFrame : NSObject

- (instancetype)initWithTextureRef:(GLuint)texture;

- (instancetype)initWithTextureOptions:(IRVPGLTextureOptions)textureOptions;

- (instancetype)initWithFramebufferSize:(IRVPGLSize)framebufferSize;
- (instancetype)initWithFramebufferSize:(IRVPGLSize)framebufferSize
                         textureOptions:(IRVPGLTextureOptions)textureOptions;

- (instancetype)initWithCMSmapleBuffer:(CMSampleBufferRef)sampleBuffer;
- (instancetype)initWithCMSmapleBuffer:(CMSampleBufferRef)sampleBuffer
                        textureOptions:(IRVPGLTextureOptions)textureOptions;

- (instancetype)initWithCVPixelBuffer:(CVPixelBufferRef)pixelBuffer;
- (instancetype)initWithCVPixelBuffer:(CVPixelBufferRef)pixelBuffer
                       textureOptions:(IRVPGLTextureOptions)textureOptions;

@property (nonatomic, assign, readonly) IRVPFrameType type;
@property (nonatomic, assign, readonly) GLuint texture;
@property (nonatomic, assign, readonly) IRVPGLTextureOptions textureOptions;
@property (nonatomic, assign, readonly) IRVPGLSize framebufferSize;
@property (nonatomic, assign, readonly) CMSampleBufferRef sampleBuffer;
@property (nonatomic, assign, readonly) CVPixelBufferRef pixelBuffer;

- (void)uploadIfNeed:(IRVPFrameUploader *)uploader;
- (BOOL)didUpload;

- (void)lock;
- (void)unlock;

@end

NS_ASSUME_NONNULL_END
