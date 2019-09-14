//
//  IRVPContext.h
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IRVPContext : NSObject

@property (nonatomic, strong, readonly) EAGLContext * mainGLContext;

@end

NS_ASSUME_NONNULL_END
