//
//  IRVPObjectQueue.h
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IRVPObjectQueue : NSObject

- (void)putObject:(id)object;
- (id)getObjectSync;

- (void)destory;

@end

NS_ASSUME_NONNULL_END
