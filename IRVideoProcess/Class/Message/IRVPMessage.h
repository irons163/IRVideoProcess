//
//  IRVPMessage.h
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, IRVPMessageTypeOpenGL)
{
    IRVPMessageTypeOpenGLIdle,
    IRVPMessageTypeOpenGLSetupContext,
    IRVPMessageTypeOpenGLSetupFramebuffer,
    IRVPMessageTypeOpenGLDrawing,
    IRVPMessageTypeOpenGLClear,
};

@interface IRVPMessage : NSObject

+ (instancetype)messageWithType:(NSUInteger)type object:(id)object;

@property (nonatomic, assign) NSUInteger type;
@property (nonatomic, strong) id object;

@end

NS_ASSUME_NONNULL_END
