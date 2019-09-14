//
//  ViewController.m
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import "ViewController.h"
#import "IRVPVideoCamera.h"

@interface ViewController ()

@property (nonatomic, strong) IRVPVideoCamera * videoCamera;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.videoCamera = [[IRVPVideoCamera alloc] init];
    [self.videoCamera startRunning];
}


@end
