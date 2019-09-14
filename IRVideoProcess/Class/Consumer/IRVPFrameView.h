//
//  IRVPFrameView.h
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IRVPInput.h"
#import "IRVPContext.h"

NS_ASSUME_NONNULL_BEGIN

@interface IRVPFrameView : UIView <IRVPInput>

- (instancetype)initWithContext:(IRVPContext *)context;

@property (nonatomic, strong, readonly) IRVPContext * context;

@end

NS_ASSUME_NONNULL_END
