//
//  IRVPVideoCamera.m
//  IRVideoProcess
//
//  Created by irons on 2019/9/14.
//  Copyright © 2019年 irons. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "IRVPVideoCamera.h"

@interface IRVPVideoCamera () <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession * captureSession;
@property (nonatomic, strong) AVCaptureDevice * videoDevice;
@property (nonatomic, strong) AVCaptureDeviceInput * videoInput;
@property (nonatomic, strong) AVCaptureVideoDataOutput * videoOutput;

@property (nonatomic, strong) NSMutableArray <id <IRVPInput>> * inputs;

@end

@implementation IRVPVideoCamera

- (instancetype)initWithContext:(IRVPContext *)context
{
    if (self = [super init])
    {
        _context = context;
    }
    return self;
}

- (void)startRunning
{
    self.videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!self.videoDevice)
    {
        return;
    }
    
    self.captureSession = [[AVCaptureSession alloc] init];
    [self.captureSession beginConfiguration];
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.videoDevice error:nil];
    [self.captureSession addInput:self.videoInput];
    
    self.videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    [self.videoOutput setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
    [self.videoOutput setSampleBufferDelegate:self queue:dispatch_get_global_queue(0, 0)];
    [self.captureSession addOutput:self.videoOutput];
    
    self.captureSession.sessionPreset = AVCaptureSessionPreset1280x720;
    [self.captureSession commitConfiguration];
    [self.captureSession startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    NSLog(@"%@", sampleBuffer);
    IRVPFrame * frame = [[IRVPFrame alloc] initWithCMSmapleBuffer:sampleBuffer];
    for (id <IRVPInput> obj in self.inputs)
    {
        [obj putFrame:frame];
    }
}

- (void)captureOutput:(AVCaptureOutput *)output didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    NSLog(@"%s", __func__);
}

#pragma mark - IRVPOutput

- (void)addInput:(id <IRVPInput>)input
{
    if (input)
    {
        if (!self.inputs)
        {
            self.inputs = [[NSMutableArray alloc] init];
        }
        [self.inputs addObject:input];
    }
}

- (void)removeInput:(id <IRVPInput>)input
{
    if (input)
    {
        [self.inputs removeObject:input];
    }
}

@end
