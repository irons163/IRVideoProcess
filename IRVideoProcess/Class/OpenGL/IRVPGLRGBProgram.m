//
//  IRVPGLRGBProgram.m
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import "IRVPGLRGBProgram.h"
#import "IRVPGLProgram.h"

#define KTV_GLES_STRINGIZE(x) #x

static const char vertex_shader_string[] = KTV_GLES_STRINGIZE
(
 attribute vec4 position;
 attribute vec2 textureCoordinate;
 varying vec2 varying_textureCoordinate;
 
 void main()
 {
     varying_textureCoordinate = textureCoordinate;
     gl_Position = position;
 }
 );

static const char fragment_shader_string[] = KTV_GLES_STRINGIZE
(
 uniform sampler2D samplerRGB;
 varying mediump vec2 varying_textureCoordinate;
 
 void main()
 {
     gl_FragColor = texture2D(samplerRGB, varying_textureCoordinate);
     //     gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
 }
 );

@interface IRVPGLRGBProgram ()

@property (nonatomic, strong) IRVPGLProgram * program;

@end

@implementation IRVPGLRGBProgram

- (instancetype)init
{
    if (self = [super init])
    {
        self.program = [[IRVPGLProgram alloc] initWithVertexShaderCString:vertex_shader_string
                                                     fragmentShaderCString:fragment_shader_string];
        if (self.program.linkSuccess)
        {
            _position_location = [self.program attributeLocation:@"position"];
            _textureCoordinate_location = [self.program attributeLocation:@"textureCoordinate"];
            _sampler_location = [self.program uniformLocation:@"samplerRGB"];
        }
    }
    return self;
}

- (void)bindTexture:(GLuint)texture
{
    glActiveTexture(GL_TEXTURE4);
    glBindTexture(GL_TEXTURE_2D, texture);
    glUniform1i(self.sampler_location, 4);
}

- (void)use
{
    [self.program use];
}

@end
