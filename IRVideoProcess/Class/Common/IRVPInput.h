//
//  IRVPInput.h
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRVPFrame.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IRVPInput<NSObject>

- (void)putFrame:(IRVPFrame *)frame;

@end

NS_ASSUME_NONNULL_END
