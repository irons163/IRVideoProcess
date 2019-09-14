//
//  IRVPGLRGBProgram.h
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IRVPGLRGBProgram : NSObject

@property (nonatomic, assign, readonly) GLint position_location;
@property (nonatomic, assign, readonly) GLint textureCoordinate_location;
@property (nonatomic, assign, readonly) GLint sampler_location;

- (void)bindTexture:(GLuint)texture;
- (void)use;

@end

NS_ASSUME_NONNULL_END
