//
//  ViewController.m
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import "ViewController.h"
#import "IRVPVideoCamera.h"
#import "IRVPFrameView.h"

@interface ViewController ()

@property (nonatomic, strong) IRVPContext * context;
@property (nonatomic, strong) IRVPVideoCamera * videoCamera;
@property (nonatomic, strong) IRVPFrameView * frameView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.videoCamera = [[IRVPVideoCamera alloc] init];
//    [self.videoCamera startRunning];
    
    self.context = [[IRVPContext alloc] init];

    self.frameView = [[IRVPFrameView alloc] initWithContext:self.context];
    self.frameView.frame = CGRectMake(0, 20, 360, 640);
    [self.view addSubview:self.frameView];

    self.videoCamera = [[IRVPVideoCamera alloc] initWithContext:self.context];
    [self.videoCamera addInput:self.frameView];
    [self.videoCamera startRunning];
}


@end
