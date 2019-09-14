//
//  IRVPGLDefines.h
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#ifndef IRVPGLDefines_h
#define IRVPGLDefines_h

#import <Foundation/Foundation.h>

typedef struct IRVPGLSize {
    int width;
    int height;
} IRVPGLSize;

typedef struct IRVPGLRect {
    int x;
    int y;
    int width;
    int height;
} IRVPGLRect;

typedef struct IRVPGLTextureOptions {
    GLenum minFilter;
    GLenum magFilter;
    GLenum wrapS;
    GLenum wrapT;
    GLenum internalFormat;
    GLenum format;
    GLenum type;
} IRVPGLTextureOptions;

#endif /* IRVPGLDefines_h */
