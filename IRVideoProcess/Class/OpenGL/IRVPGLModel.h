//
//  IRVPGLModel.h
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IRVPGLModel : NSObject

- (void)bindPosition_location:(GLint)position_location textureCoordinate_location:(GLint)textureCoordinate_location;
- (void)bindEmpty;
- (void)draw;


#pragma mark - Override

- (GLushort *)indexes_data;
- (GLfloat *)vertices_data;
- (GLfloat *)textureCoordinates_data;

- (int)indexes_count;
- (int)vertices_count;

@end

NS_ASSUME_NONNULL_END
