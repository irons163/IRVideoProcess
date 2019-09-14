//
//  IRVPGLProgram.h
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IRVPGLProgram : NSObject

- (instancetype)initWithVertexShaderCString:(const char *)vertexShaderCString
                      fragmentShaderCString:(const char *)fragmentShaderCString;
- (instancetype)initWithVertexShaderString:(NSString *)vertexShaderString
                      fragmentShaderString:(NSString *)fragmentShaderString;

@property (nonatomic, copy, readonly) NSString * vertexShaderString;
@property (nonatomic, copy, readonly) NSString * fragmentShaderString;

@property (nonatomic, assign, readonly) BOOL linkSuccess;

- (GLuint)attributeLocation:(NSString *)attributeName;
- (GLuint)uniformLocation:(NSString *)uniformName;

- (void)use;

@end

NS_ASSUME_NONNULL_END
